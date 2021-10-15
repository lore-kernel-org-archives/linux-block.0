Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1B2C43219
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01681611C1
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhJOPsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbhJOPr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 11:47:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D0EC061769
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 08:45:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so6629035plk.10
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XFM5WavD2dlHj0k2cmbjEUH7DswNvraUTvaUeecsFLI=;
        b=kI3cmovLUq4/7b3XdGijH4QV2pLukclN+qtvDChdq76oCBSEjB/PxJ/LWqXaiWG3Ff
         e4ufh94HB0JHTcED5LMZgB7kXmiVxJYf75rZOCTtrAggeGm0/wa2OqJYCFCBhzazIF7l
         udxg7lVjqVFbJpk0sBDk4exc+CKZoXIIyRuqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFM5WavD2dlHj0k2cmbjEUH7DswNvraUTvaUeecsFLI=;
        b=kQj5UWn/yNQ1oRvK+iKwnNY+52Rb+5xNDNXJl5OVcwmQjdcprXWfbXt+Kmwv3MNrVn
         oAvImipxcOPekgTwibkTgD4IWvxXBTz3KBBk2q0r8w1VB6vnZb+o5QEosfZ/bD7mPFXD
         1XkiX8F0ySZbTdMOu+nUc/3GGqAo4OQmgukKaXvRQyJOQ+My113Rb4HPyllRfpeo/diM
         Ozvbg7Q7PWc95rN+y56BFb2BVqkW8C0jXZCUzTpKIv94tTs8yKk3tADq1HzNX6h+C/1y
         ZDRBjZpS59N7KNqXLEEsWn1sVsCBEooYEdALOffMJw5IZTYwdIgcPQLZNQH2xkgwFe1M
         mDMg==
X-Gm-Message-State: AOAM5302WVLT2lH+2t6ZjrLb1VRrVmMkkOlwcQu4pEWijOnHlCFa8Xal
        yO6zh+3wAqiiKQ3HLRh56Oac0g==
X-Google-Smtp-Source: ABdhPJwzQs+V6r1hPLOTwtZOgiRq0ZYBjWTuzen8H9dNT74QaE01sJDiES/7Q1kbrrYk+yq2JOau2g==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr28243106pja.190.1634312751709;
        Fri, 15 Oct 2021 08:45:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm5328859pfu.22.2021.10.15.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 08:45:51 -0700 (PDT)
Date:   Fri, 15 Oct 2021 08:45:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 01/30] block: move the SECTOR_SIZE related definitions to
 blk_types.h
Message-ID: <202110150845.29BA04E647@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:14PM +0200, Christoph Hellwig wrote:
> Ensure these are always available for inlines in the various block layer
> headers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Awesome, yes. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
