Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382BC31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94EA2085A
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfFRP3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:29:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33207 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfFRP3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 11:29:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so7894742pga.0
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 08:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FPkd41xt7U4ugAwaP49rp1COAqT6prP55gZW8vSYIZY=;
        b=tYjzxd27/kt8K8gxZW5paOfzZvS3D1Bze3cGCyYSNG9d2RsHb/WEPSfpP65sFXbm07
         3VT5HE1tMyjIq7xOZF3qG9hWJzLExroPFNMofBUbWDMKMsFlRL2NfURiJ/E+F5/XDgzY
         gojFwO2Ub7Tq5BsqzQu58MXItovZ0fA4Fv/I6mvqyBjTa+ze6jZkNlbnB51KuE6aUy4D
         oFpGw0keNA/SEW2fOGWPHdktFJHRuYupIQfEeI9CFKAvsRGU2n+CQiU/rWBGBK4I3Xky
         Ayxlvi3Y6ecEuBIgCKKot6t7T/3mtPpT7LyKwVD1jehSf+OfUYoUUxb3UZxPKkdzWpzl
         rqvg==
X-Gm-Message-State: APjAAAWUPmUORs/wVhmXkjodvotZji743kEtjqNklkUwLi6iTs+mmBuM
        eUxzptsKwR9L3vXhmB+VtS8=
X-Google-Smtp-Source: APXvYqxQt6GKaC7VuIqU00kDI6soqUkiU2V2cNEypMb7cEGG4HLPRQB/ze6qOME61N/bKVxvQ4whhQ==
X-Received: by 2002:a63:214a:: with SMTP id s10mr3207924pgm.13.1560871762338;
        Tue, 18 Jun 2019 08:29:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t24sm15044080pfh.113.2019.06.18.08.29.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:29:21 -0700 (PDT)
Subject: Re: [PATCH V3 6/6] f2fs: get rid of duplicate code for in tracing
To:     Chao Yu <yuchao0@huawei.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-7-chaitanya.kulkarni@wdc.com>
 <088167e2-8744-5176-f282-7015d02482fa@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <be26b895-f8e3-e4ff-eea8-a2f4ada16b52@acm.org>
Date:   Tue, 18 Jun 2019 08:29:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <088167e2-8744-5176-f282-7015d02482fa@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/19 12:19 AM, Chao Yu wrote:
> Hi Chaitanya,
> 
> On 2019/6/18 13:42, Chaitanya Kulkarni wrote:
>> Now that we have used the blk_op_str(), get rid of show_bio_type() and
>> show_bio_op() to eliminate the duplicate code.
> 
> I think we can merge 5/6 and 6/6 into one patch.

Yes please.

Bart.
