Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAAEC54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 17:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1577206D9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z5G8gTId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDURiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDURiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 13:38:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F319C0610D5
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 10:38:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so14145656ilh.8
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpJBLOxy5qnZowwRZZ4q61vukLmgP0WamNnQ85DlCzI=;
        b=z5G8gTIdeL6UM6UjrXsYyfMjf4gUkI0xza4M8cANA0/Y0odLIOyzFp7DCUTy0DJEzP
         KPOusGZSwnY5VTsbGfc+LCNkDwOMu/ZuOLtxuESYvQVQyq6gKqnOqBlyX9bcMtX70lH7
         N2ffLCy2aPJLqB6cZjrLQsqyPwlJmrBUMCSDj4CYBl2cvzLMoBI82+HFwsNlgz/CNyfJ
         36P5Ov5gi9uJJLAdNohPMB/bGE3v2emJ0BymdjkXSfgExN1JlIaIadHl9tqbQG9L4UJW
         bcEm0GCGcEp5a71+dEk2+vl4erVU5uhkcXLvxVagtF940NfU8vLjfVcbBgFexZsmwIU0
         eBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpJBLOxy5qnZowwRZZ4q61vukLmgP0WamNnQ85DlCzI=;
        b=XxJ4jajbsirR+TeXeTJVfTYnNOuusMbSxp3bBy7Y6m4fjbph6LNiUV8BudK4CAH5n9
         VTLm+uGbUUCephaLAYX8oH4xY1G7M73PwR48oM+eHrU+z/z3DDUgQ8hkF7VWCIqXN6a8
         gRJsXMBRKPLJ3Ydyw77DVw1u9Kpt3E5rS7L+HkjTGjAzqIRxYrdaIMQIfzGUG6qtC9fo
         6EImMxTMxLpNsEKkARqlzS2ezXWSc48evvEsI3M7TBNX6avQ5dyKbpT7Ha1KeF+zbpEK
         Uj6N1DNW4yt+rozIgweDxCOl8IOLfKs5Pd+uNKWKPsUsKQTuq2sHDBoNK36Km//HAZBG
         atcQ==
X-Gm-Message-State: AGi0PubukqUHOq5xmzdhYZY4FS/PL62qT+fS88J3ohXwEoiUkpb70r1u
        SF4HJuob+5MX3+2EZKW6T53W4A==
X-Google-Smtp-Source: APiQypLwIcO5fQ1X7DQpkKn733bw9MaeTjNtAGk+05zKkGNu9O6BzlNrLXS2ydU2eFfSTC1LvNtCuQ==
X-Received: by 2002:a92:405:: with SMTP id 5mr2318137ile.279.1587490686761;
        Tue, 21 Apr 2020 10:38:06 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j11sm1126251ild.1.2020.04.21.10.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 10:38:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] null_blk cleanup and fix
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
 <BY5PR04MB69002C510DECF1439C33FD32E7D50@BY5PR04MB6900.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebd01ecd-0e4f-9a23-3dfb-d11f9c3e0771@kernel.dk>
Date:   Tue, 21 Apr 2020 11:38:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB69002C510DECF1439C33FD32E7D50@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/20 3:10 AM, Damien Le Moal wrote:
> Jens,
> 
> On 2020/04/01 10:07, Damien Le Moal wrote:
>> Jens,
>>
>> The first patch of this series extracts and extends a fix included in
>> the zone append series to correctly handle writes to null_blk zoned
>> devices. The fix forces zone type and zone condition checks to be
>> executed before the generic null_blk bad block and memory backing
>> options handling. The fix also makes sure that a zone write pointer
>> position is updated only if these two generic operations are executed
>> successfully.
>>
>> The second patch is from Johannes series for REQ_OP_ZONE_APPEND support
>> to clean up null_blk zoned device initialization. The reviewed tag
>> from Christoph sent for the patch within Johannes post is included here.
>>
>> Please consider these patches for inclusion in 5.7.

Can you respin for block-5.7? The series doesn't apply.

-- 
Jens Axboe

