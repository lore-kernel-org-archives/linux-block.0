Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B38C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF761075
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhJFNbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231403AbhJFNbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Oct 2021 09:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzQmzBUEihVkKDDjIOOM5bJWBT7h0GK8QC/ZlgQykqs=;
        b=i5tP3pinYcf1oGJX/YTXOhc9Qd4zocU+QtT6ShOwAvhTo8EQnHPfvgTQgbeKX3tws2AOOW
        rUrVotiVTv7zWfiguSCZp5ExD9ruQt3egvn/64TwY0W6Yh7iFYxZ61w9zSJyHz9iRfwigq
        0rvBU76iZ6pi/epe83A/Uhc5RVuOJ9g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-D2XD9oEFNZKk20Xlz8E7Cg-1; Wed, 06 Oct 2021 09:29:14 -0400
X-MC-Unique: D2XD9oEFNZKk20Xlz8E7Cg-1
Received: by mail-qk1-f197.google.com with SMTP id i16-20020a05620a249000b004558dcb5663so2159594qkn.9
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 06:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzQmzBUEihVkKDDjIOOM5bJWBT7h0GK8QC/ZlgQykqs=;
        b=LAwWAQKO76h21ZXk22U5c6pHdoa0c5mDpdv2ubFudZ8rCcOQjw8zzwXBJb5rKBUltn
         n4qAvT37eGKLCyFbBJPhmYymPxHTQ+K3KXStU0YL2CGt1uuWDfUveYkdFZwhLrDCX3Q1
         23DWP+hI/yvVH8kemdbZnoFHHG70Iki3twnapBATWoGlK+BUS5ZC/I+xYwT3rr1ATNyL
         g/PYSBam8WEk6dv15DcffK4gVdcnwoIu4kkLB0PjR8tZlsPc7/n4HFOCrKahQIu45ecq
         44fALdrgVk3OkVERaedyB0GaKziPWthKJLiFTRE9FrP/9Dd6rqKZQZOQo+ekG/MjCN4u
         rtzA==
X-Gm-Message-State: AOAM530LccuYVsEC0Q0FgF/VUsatgczLettiU2wlnQf8WmKSfj3xymYh
        i6q3xAyPHuKxHkqUrhqtyW4svSD5FD7tnVDWE1Cx9zyD2/cS6V4V3Yw5YftVbMCj7goEkn8rAGu
        2ATmQh/DLYtFuxZaKICqJrkfpeBTqh1hwR+punvmRRhfJ2mwMsHY2eWCzmBTqiHfvw4/eWiTq
X-Received: by 2002:ac8:88:: with SMTP id c8mr7511097qtg.12.1633526953830;
        Wed, 06 Oct 2021 06:29:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/8v3wqkJ1Y5E44+yD/hKM+9kQgCyFGq7beETeqK37nW1j+ndjaNNfhnHZDIHaVp6v5rSBYQ==
X-Received: by 2002:ac8:88:: with SMTP id c8mr7511066qtg.12.1633526953614;
        Wed, 06 Oct 2021 06:29:13 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z6sm950959qke.24.2021.10.06.06.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:29:13 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:29:12 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>, dm-devel@redhat.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 4/4] blk-crypto: update inline encryption documentation
Message-ID: <YV2kqFA3y3qo8ls/@redhat.com>
References: <20210929163600.52141-1-ebiggers@kernel.org>
 <20210929163600.52141-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929163600.52141-5-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29 2021 at 12:36P -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Rework most of inline-encryption.rst to be easier to follow, to correct
> some information, to add some important details and remove some
> unimportant details, and to take into account the renaming from
> blk_keyslot_manager to blk_crypto_profile.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

