Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D09C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD843208C7
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jicrp3hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHDN1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHDN1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 09:27:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790BDC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 06:27:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g19so10267837plq.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHjfcRue8tkcrKLVefay3tigQoGXJx0kTyOmB4Hit7I=;
        b=Jicrp3hOXSpnN74Mo2md7PYEYi+ldOBHuzVjSkFC7qUu0w9HVX+jXYaX2nKO96eVzo
         2BCA4KBiP9eryZ+KHBDWi4ZXP364bB8xBJVJ+nJf4AW3NYDlKA8H/H2ETsRz0s2p+G7b
         Ay5AP60hXw970DeIRrl8Z/ZD6AhGzxCRWnmdqvSaD/IyH3IlU7V70pkwk6f09JAnTgoj
         /EJ1Cy98IAfuAzSp94+jqE/BOfnZUwpTx3Tf5tg4lomUWIV3YsX1lGcHyeqh+BGyJO//
         Wq4EWTvNmITBmpsLwRs0K7CwjEU/bUz5SzhmMhtMRKZTa4Z5XyRTAssO4/XOcftphhqb
         mrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHjfcRue8tkcrKLVefay3tigQoGXJx0kTyOmB4Hit7I=;
        b=Mos1p0p2wzLGizaum35lgi96gbaE6fIdjNJvTpwNxUCxng+ig/+sO0HjZsSTiJ9iYZ
         h+hoqf8SouEXZXgdc5jYoi/4B2Sf6wdRfXtD4WF6cykfbsUT5fZOKmGLKXhNv0NWp2ne
         tGQRAIe1b/zv4XHFAtt6jVbtmMueB6hbG/vbOuAvvDtkB2gOOl0d+gdh0rcjf0ru6UOy
         IuKbugS4VSz3MxrQm6Vt5K0yyHXu5WMh4ayyVMpwENHYkHSWeo0As0jT/70Reis2J0Dr
         zxUmOsK8vtiS+lYVC9vi6ZL/0G74KCnkNPc//WyASKllR2VTeNJWwSn4iRSdTZeWnWRh
         d9nw==
X-Gm-Message-State: AOAM533jM2p5pcD4SCrH1JtGnKABl5qBc+bG/5YwDjqu0lB1axi7Jvgg
        Ffogq3sqGGzz5TS5ao+509CcCg==
X-Google-Smtp-Source: ABdhPJzLEz1L+6AAPxo0GXOLtwSba9g/B9LgLpLIrHM7kOLxRaBloS+RslChtI/x0DxtClQpnj9clw==
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr4255973pjb.115.1596547637007;
        Tue, 04 Aug 2020 06:27:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id il10sm3078756pjb.54.2020.08.04.06.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:27:16 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: fix null ptr deference in
 io_send_recvmsg()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Liu Yong <pkfxxxing@gmail.com>
Cc:     linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20200804125637.GA22088@ubuntu>
 <701640d6-fa20-0b38-f86b-b1eff07597dd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0350a653-8a3e-2e09-c7fc-15fcea727d8a@kernel.dk>
Date:   Tue, 4 Aug 2020 07:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <701640d6-fa20-0b38-f86b-b1eff07597dd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/20 7:18 AM, Pavel Begunkov wrote:
> On 04/08/2020 15:56, Liu Yong wrote:
>> In io_send_recvmsg(), there is no check for the req->file.
>> User can change the opcode from IORING_OP_NOP to IORING_OP_SENDMSG
>> through competition after the io_req_set_file().
> 
> After sqe->opcode is read and copied in io_init_req(), it only uses
> in-kernel req->opcode. Also, io_init_req() should check for req->file
> NULL, so shouldn't happen after.
> 
> Do you have a reproducer? What kernel version did you use?

Was looking at this too, and I'm guessing this is some 5.4 based kernel.
Unfortunately the oops doesn't include that information.

-- 
Jens Axboe

