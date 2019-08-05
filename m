Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DFFC0650F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 21:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6489E20B1F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 21:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ipWqF/HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfHEV2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:28:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHEV2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 17:28:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so40379186pgi.6
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6otElHpgyEjGVoCaiPv8i7EM/fhujFlztleZHUQiOo=;
        b=ipWqF/HAH+6HlfjFTSBpvvJdX/JOHAUgEu9I865i1VytvifXLUltZ+GpjYVIbxQqUd
         Db/cdwVEo7qIcdiAyJYF8pv0nz7N8Xqxe9MSTs3zWth7p5SHAP1nXHmC18l7Ji/MY4D5
         jX9pzgC08OQyb1N3eZlo9r+soaDSNgEXFsIn/L3od6UJkSLUHM6y5fhU2OED1jQc+Q8d
         QP1V2SdYn6vlANbU5j4044rRgVjD6Gv+Hm1uuYp1dDVzHiUJLfWXWoPeW1dDBs98tD7x
         UucCVAm5567IJhdBfWHCujMtSsPM5j2j7UYUrZscu5JnmxC1xcoRLzk5emnpBWiEqOUJ
         N6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6otElHpgyEjGVoCaiPv8i7EM/fhujFlztleZHUQiOo=;
        b=haVy4JsUKpZ9HrQYCSo0/JJFU88UYIjkfSAfzhM06M2qkSJV4YUsYELTpNlMkG0Qt2
         d6lmhFkwSrXlMnvmsp12q4kfw07v0is1uNSnwf8zrr9YahXlP8QNJrqihyrPpzBxnZwR
         bqfXOPdl+E+DAq9y4Qq1S1+Uiw2p5OEc3ipWXII/+vQeAax22cZeCWq7rnTYNgF0CKF7
         Uo5tEYcgcXoWk8f6bHXXzlkm9xsZUN+UttGC6u4dSKPd6GR5ZYYPTlYSGyevfahlB658
         t5/SkoIW8I5HPurgime/OzJsi2a2/Q0atzo/GDCAzFnC14gH5F29iBD6apprEXKHYQye
         RS0w==
X-Gm-Message-State: APjAAAWnL7y4QsRLcdnLWaeJ9REwm6CBB3T/K7Gkw44kQ7T9S6HTvRx+
        WDc6fjSs7ZyI3bycgbUlUTY4sVxGxkXeJg==
X-Google-Smtp-Source: APXvYqzhBKyuLsOVHEc9c+i1pQSjZRDiztraq1AEHUUx1LXgn6ddJ44fS1ID4RKnjDCsFNAYtvEr8Q==
X-Received: by 2002:a17:90a:d14a:: with SMTP id t10mr20304779pjw.85.1565040530775;
        Mon, 05 Aug 2019 14:28:50 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:3cf5:36ed:899e:8d54? ([2605:e000:100e:83a1:3cf5:36ed:899e:8d54])
        by smtp.gmail.com with ESMTPSA id d2sm16985134pjs.21.2019.08.05.14.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 14:28:49 -0700 (PDT)
Subject: Re: Block device direct read EIO handling broken?
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
Date:   Mon, 5 Aug 2019 14:28:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/19 2:27 PM, Damien Le Moal wrote:
> On 2019/08/06 6:26, Jens Axboe wrote:
>>> In any case, looking again at this code, it looks like there is a
>>> problem with dio->size being incremented early, even for fragments
>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in
>>> blkdev_bio_end_io(). So an incorrect size can be reported to user
>>> space in that case on completion (e.g. large asynchronous no-wait dio
>>> that cannot be issued in one go).
>>>
>>> So maybe something like this ? (completely untested)
>>
>> I think that looks pretty good, I like not double accounting with
>> this_size and dio->size, and we retain the old style ordering for the
>> ret value.
> 
> Do you want a proper patch with real testing backup ? I can send that
> later today.

Yeah that'd be great, I like your approach better.

-- 
Jens Axboe

