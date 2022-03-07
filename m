Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE5C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiCGU4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245561AbiCGU41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 15:56:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DB3982F
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 12:54:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 9so15123410pll.6
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 12:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GmTFXiML6pNNzmCqyWPvwXWBYIR1paMrsQsVEa8lOeM=;
        b=WvTxCOQ+1daG+E0QBmtrZE5nS6ZMldO3WZr+Fohg+u9cCI80YrVLUwWL/MNNQ5/rpn
         8OYhIThy94qePKuF+2kGoXvmFT2Rc0WD2+CeqoNyS9HhvvhDcL28G0NnQYlA/nqhhnVh
         RcSiCy56vPNSh0brUzYWMAC5RhR9fvTH07zWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GmTFXiML6pNNzmCqyWPvwXWBYIR1paMrsQsVEa8lOeM=;
        b=KfXqlBlL5eFr4ly8oGFpgfbGZFlK9hgqVpDJ5Ye5K/mVN3ub0cm2vHfzzhyLpnIjYz
         V9hPwtN2yxcgUwmY6Wh6BTENahz77cYWoJX7848MrnslpGT0/euQCZVfanJzL+5gXCqp
         j8YgV94w2sEVpxPFmxMLCPNKPR5PdhH7AML7TSBbddWB0YjF1V6IzkoAnauR2obLl/YF
         yz+173+AOpMdmkFagDFoql1ezfWP0T/w6FfhQjPR9/cjIvUTI/cdhZ6bj3DYUzXUFnAX
         7E7hyt/knlTYZOitQ7kSMIV/eYLVxVddNgnr3PYIAW/Ot0w+QiR4CFRPR2glnG+kiC8Z
         2/YA==
X-Gm-Message-State: AOAM533qaKTPqpjsKNw84mbKNcXPzpy38ZyCFJj2ji3UtmEoCWh6OThZ
        k78m7DwaCw4JwtKrynPVsKZyYkBf7Zf+jA==
X-Google-Smtp-Source: ABdhPJwGFXP2SMzUSdYuyXRJGzI2qDstRpNw9psmgOBPqHb5rWPLrPGJzr8NBLFRzhKAq8oirlHj4Q==
X-Received: by 2002:a17:903:41c1:b0:151:ed5e:6bc4 with SMTP id u1-20020a17090341c100b00151ed5e6bc4mr5908434ple.113.1646686495162;
        Mon, 07 Mar 2022 12:54:55 -0800 (PST)
Received: from dev-ushankar.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a414c00b001bf6d88870csm229642pjg.55.2022.03.07.12.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:54:54 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:54:51 -0700
From:   Uday Shankar <ushankar@purestorage.com>
To:     Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: emit disk ro uevent in device_add_disk()
Message-ID: <20220307205451.GA1765432@dev-ushankar.dev.purestorage.com>
References: <20220303175219.272938-1-ushankar@purestorage.com>
 <6f24cfc9-09b9-67bc-d15b-d3aff238d923@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f24cfc9-09b9-67bc-d15b-d3aff238d923@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 07:39:39AM +0100, Hannes Reinecke wrote:
> Why not add the 'DISK_RO=1' setting directly to the 'add' event?
> That would be the logical thing to do, no?
I agree, and initially had a patch that did just this. However, for SCSI
disks the DISK_RO property is only ever announced via change uevents,
and applications such as dm-multipath may not pick up on DISK_RO if it
shows up in an add uevent instead. This patch maintains compatibility
with SCSI in that sense. 

Christoph Hellwig wrote:
> I don't see any such pattern there.
Note how sd_revalidate_disk (which does readonly setting) is called both
before and after device_add_disk. Note also how set_disk_ro is called
twice in sd_read_write_protect_flag, to ensure that the ro state flips
(at least in the case where the ro state should be 1). The only
reasoning I can think of for this pattern is the one I mentioned.

> I also don't see what the point is.  KOBJ_CHANGE uevents tell about a
> change in device state.  But if a device is marked read-only before
> disk_add that read-only state is already visible by the time the
> device is added and thus shows up in sysfs, and we do not need an
> extra notification.
You are suggesting that I should patch the applications I care about to
pick up the ro state from sysfs instead of waiting for a change uevent,
correct?

Thanks,
Uday
