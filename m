Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1314C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91F320675
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 14:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="njfWymmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAOOb1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:31:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36712 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOOb1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 09:31:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so1402497pfc.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jan 2019 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q31woSiCRDDJCOFWHnRj/ghCcu6QK6UEGBYFW/geGTU=;
        b=njfWymmX97QGXXpqW+6kz9FLGHq7GNrhB3mnaUSF3iNJpioWVD7ZgpYfrOsINUvrhw
         Nz30FZdHion4mbINQI9DC6ZQtSnThw3E5ahNVydVZ8oAjfxKCsH+iDP/4yIhqx7odE1y
         s2FRdTrJ0I9bKikJKbXuwfzbnw68MbkPUWxPs+zUBVIzARuFLenoKakSGx1qkmqtDCEk
         xxZa9IS5T9BSrvtzGHDzBJVRDEIdkhGuGNZO/jHb1hejw1/gpVGdqk4ZdbVqH9LipSHn
         IzWxCpRuzRHZbMpO2eBy3XHkEbtfcEaP5U1HyC8MLiWQAf9rMwyNLxZ/h71+8xv4mxfG
         3Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q31woSiCRDDJCOFWHnRj/ghCcu6QK6UEGBYFW/geGTU=;
        b=YIrLAHg2ZtxEhSo14EvaIB7rIcd443qzmks7GlXRyAeDs+vNpmMdfx2tjVSE44VjZ8
         WgiXgkHtHC4/NTfLEIJcWAqlgHv4t9ZPrL5D6WbpVMXd4maCFjWztQjr1kK3sosFGFDg
         Zz67OCFIpQhZFQYDdCT1iTrpfyLHxxAOBv0vfdBN7D87i3bGIc2r1g+QfHDou1X8AqP8
         +MOO9LshIMjvdAJy9ssJhlh7CUnbskvmfa7XompfI6hC86ZEgNEJa7GYzVXHR4AP4WuF
         xifV2dtRNpfCMnTwGlhQXuwZSmWPiRBOFz0tLDopnfwol5ixekmdcj3h9zUVPBreCDUe
         JmEA==
X-Gm-Message-State: AJcUukeKqGEokPlje3EN98QI/Q7EGjHluDanckvCzyuYqFpiCRcm9zMO
        aZ21buuK8GPldNThZrtG18jFsqsJEE1zRQ==
X-Google-Smtp-Source: ALg8bN4fvshRQWQFMTs+nnme7n4Un9QajOECOutqr+PwKCBW+o4gVyNO9gAs1J0XoVl7vK60d9+3OQ==
X-Received: by 2002:a63:3287:: with SMTP id y129mr4076351pgy.337.1547562685827;
        Tue, 15 Jan 2019 06:31:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm6816587pfa.38.2019.01.15.06.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 06:31:24 -0800 (PST)
Subject: Re: [PATCH 0/2] blkdev: Fix livelock when loop device updates
 capacity
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20190114084811.14455-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81413910-c4ce-6380-e989-94de0d11ce2e@kernel.dk>
Date:   Tue, 15 Jan 2019 07:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114084811.14455-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 1:48 AM, Jan Kara wrote:
> Hello,
> 
> this series fixes a long standing issue with loop device which can change block
> device size under a mounted filesystem which causes infinite loop inside buffer
> head code. See patch 2/2 for details about the problem.
> 
> Note that generally it is dangerous to resize the loop device when filesystem
> is mounted on top of it. However there are some valid use cases for this (such
> as growing the loop device and then increasing the filesystem size) so we
> cannot just restrict the functionality to exclusive owners of the device.

That's really a shame...

Anyway, applied for 5.0, thanks Jan.

-- 
Jens Axboe

