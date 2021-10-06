Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87765C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FFC6115A
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhJFN1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238997AbhJFN1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Oct 2021 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REf5XfxKy2/DOMCe3ZbKnMPcGwKfHql13e1o3U4ongw=;
        b=eUjgpIH1prKDnERwNTF8S6tlHlKXwL3zPyavvqOR07pg/NpsatWV6OxI6rvcn8LZAj9oRI
        /DP3uXh5z/kuuAkntm3ae7WHtxuzGDPWXUYn7v2D3a0A6ge1GnrsT1Tqd4lV5ZS1r6uV/o
        C8nvli4uib6N1OSbz+mqIPoqox42Qwg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-7-BOGPVKONuCnY3xiNLZpA-1; Wed, 06 Oct 2021 09:25:24 -0400
X-MC-Unique: 7-BOGPVKONuCnY3xiNLZpA-1
Received: by mail-qk1-f198.google.com with SMTP id s18-20020a05620a255200b00433885d4fa7so2175313qko.4
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 06:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=REf5XfxKy2/DOMCe3ZbKnMPcGwKfHql13e1o3U4ongw=;
        b=FpcgeiA90LziryIetntVClQDZclrQn7Ut/rIDolAwbfkfdhm4FFdMsE7s8DyyTzwkB
         5U63gGB8zQaKLZFRrqMMTsr2me1+/J++tOqsxP0GzMd3J88e4B/oX4uVoPtko3tGnJK6
         hG4TGz946qJlO/qIR/s6Wu30f5FJEtr05AhpsQkInPVlSdUm/POuDuW6s/Z5jE3uiBtu
         ybhhmnJubb40LY4sY1rCTsJV8X2aDjzPCTUWPZxx3uLCP3/SIvQjsujGyXDhb6NOxday
         FUsErVAPG7jLMDvxXqccrzQz394ReuAQ59anggG/CrV87KPaBuqBxSY9gzHAPxeH3uHT
         JjkQ==
X-Gm-Message-State: AOAM533SABe9jSjp0cJ8OWtA6gz0qDYNeYptCfxethurmPsc8wh3/ylT
        w2tDFndUCYgfVLy0zenTp4tUXqkEHLSarIhtEAEcZ2Hw0sfBuv2ixcSJedyrmQQD0O3vY2JZEhT
        lU1hp2nNJ+N31Mag3SX+OXc9mrZ95Y7xicH7nk4CsOWQAroZdo3x6mPEB3sjIRJXt7txk+Atc
X-Received: by 2002:ac8:5ac7:: with SMTP id d7mr26967168qtd.382.1633526723498;
        Wed, 06 Oct 2021 06:25:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+PKn5GM9cvmQAEvw5ba5TX7RO88qJGng/rIUSvV54/GxbODRhQ88kDsUXdjhkd0AFADfwww==
X-Received: by 2002:ac8:5ac7:: with SMTP id d7mr26967139qtd.382.1633526723289;
        Wed, 06 Oct 2021 06:25:23 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m11sm11234942qkm.88.2021.10.06.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:25:23 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:25:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>, dm-devel@redhat.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 2/4] blk-crypto: rename keyslot-manager files to
 blk-crypto-profile
Message-ID: <YV2jwuFGgSfxS56K@redhat.com>
References: <20210929163600.52141-1-ebiggers@kernel.org>
 <20210929163600.52141-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929163600.52141-3-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29 2021 at 12:35P -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for renaming struct blk_keyslot_manager to struct
> blk_crypto_profile, rename the keyslot-manager.h and keyslot-manager.c
> source files.  Renaming these files separately before making a lot of
> changes to their contents makes it easier for git to understand that
> they were renamed.
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

