Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5228C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FBE206B6
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CauO67Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfAIPyB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:54:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54014 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbfAIPyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:54:01 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so12336993ita.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FOWzs6XH7o4vm5V1hMSK5LoipappHMKSsHI3X4VGS9c=;
        b=CauO67Gv2shyZ8Lt+F50h6NUB9Q59I5mtDtxfiYBDPAaq3UlNpaDjbewbIOXjVn0cx
         6EJNPWbzPn1AJKlvGBtmxbGP5mKNJcKcdbSJuEdo+biXbiFBAdCJrHMpQdY6a6a/BLKi
         wP3bEEezHh4At0561BvTeBl6VyiBXztN1peQ4nOTt1m0CbkLbQ8jGVhJbJLDQmBLcrya
         irl2VAvCviDddzOSqAp4XzSAodY02PWHkmPS4rdxwT+iHH1sDmxg4eNFpR2xGgSRiy3t
         Mue3AwQFp3ZI30hv3uj1ckMb/92pbSQt85IRy08VKELLVVigiSIm266ByMFx2evzKizP
         QDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOWzs6XH7o4vm5V1hMSK5LoipappHMKSsHI3X4VGS9c=;
        b=RHrQEuW3Q4dZPYVW7hzNr5e4xIJM6C3Eg2cWWT8w55GeATYtwEbwN0hYg35G294IsI
         gpM9+dIeF/YrH2wHLt5rCbtxPkFV/eZimD1szJgBggluSs6dG+ZcEp6QmpQ/GxE3JRIJ
         KLL9SWNHlgATPx4Pfby7PTeXXhUAVENByHYxyeagUHSOAGPegegeRak5s1RygrXEEImE
         /Un8SpBetKinrcIogmMT9TR55me8NdBxRavFd9xDsmexVp34jhr4RqUQPuAmt/TnvboW
         mvJMLnvTB/l2KbIafzRj+x/3GiAMxT5Xilrp06Udb8qwkTw/fmx6T9Caa+GEllGLmWrp
         YXqA==
X-Gm-Message-State: AJcUukfEMPyQWBilucpFFyRVUAdAPuFcS9J34tRbqPeZAD4IMOitkfCQ
        CMymjAp4ebPRpwYc55TssmT8beR52HM54w==
X-Google-Smtp-Source: ALg8bN4guXvflX9rIvW2EYpklBx03A5YDN5Uy97Ma4cvs+/g5+5cfh6CTPqK4kxhp3k9ecIgIzKDTg==
X-Received: by 2002:a24:d203:: with SMTP id z3mr3866699itf.156.1547049240311;
        Wed, 09 Jan 2019 07:54:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n4sm20295352iog.36.2019.01.09.07.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:53:59 -0800 (PST)
Subject: Re: [PATCH 06/16] io_uring: support for IO polling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-7-axboe@kernel.dk> <20190109121157.GB13779@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06e3d163-7a02-96d7-d4e1-d3a37e633192@kernel.dk>
Date:   Wed, 9 Jan 2019 08:53:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109121157.GB13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 5:11 AM, Christoph Hellwig wrote:
> On Tue, Jan 08, 2019 at 09:56:35AM -0700, Jens Axboe wrote:
>> Add polled variants of the read and write commands. These act like their
>> non-polled counterparts, except we expect to poll for completion of
>> them.
> 
> These aren't really need command variants, but a different type of context.

That is phrased poorly, I'll fix that.

>>  	case IORING_OP_FSYNC:
>> +		if (ctx->flags & IORING_SETUP_IOPOLL)
>> +			break;
>>  		ret = io_fsync(&req->fsync, iocb, false);
>>  		break;
>>  	case IORING_OP_FDSYNC:
>> +		if (ctx->flags & IORING_SETUP_IOPOLL)
>> +			break;
>>  		ret = io_fsync(&req->fsync, iocb, true);
> 
> I'd move this check into io_fsync to avoid a little duplication.

Done

-- 
Jens Axboe

