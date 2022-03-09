Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9220AC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiCIBOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCIBNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:13:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB8315B3FE
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:58:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so3727320pjb.4
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 16:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=n3kOWYi00wB/JSBNH3Nkdw571Dwb7Z4bxoeFT/f7d74=;
        b=qDe3CBPnszracgGZ3QHhnX2rqwCMCDyq1b/oMf/CwBtfCmovbYpnAA+VSbJJn6Xa48
         JtAXVaWA/XjICwCBqyZLkWAgL4gh3yktjXHABN4AEkIRHgy9Cog0P4jN2vZFDx3MEgHx
         nWDKS8ytclYRe1YHJKzjrhpXXxuI+ewUOlf/Jlbh2/zBxchqIrPm+qTJzFMIGMJitB9i
         puba+9tOjqVVXsS6wSeZZ7lEUVsEhWIPolVuFEBHYjkXuf3VXVu7ggF0vTR3+lI80jWl
         ECTGd9vaoR8txjEJk8EqcxqVLMahgNMBWlKkHgTwwuXvp/rlnSIwoN1V5Sg4HWvF8tCn
         1t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=n3kOWYi00wB/JSBNH3Nkdw571Dwb7Z4bxoeFT/f7d74=;
        b=xGen0dhJIzaKhrmmaifIXqONFZfQdu1PHeRfEr66jVDWwLT1q1JsMFCozQP9blEAPW
         gwiaXtiMg6wAb8lpkaa6+m9IbKFeennUE11hrWdMevCu2BtiIezmEHQne4vNLfWb/eQD
         a2/8O48upTFe8qI3kFcnrELBCtJRNTVQGGMgRQMi9ejyxogLx6Y3b/iSpiBre/yn89Em
         06w2GOyJXHI+g1kiMUXE65nv9RaXAGQqjAQBOh+b0Pl/lh8Fo0Mdrskq1v1XyjD7o5Ey
         u8ErLzH1YtcTdpZ1XV/Vu5bI1n24QA3ibQad0upiSD+cO2XOqhsFSVS1XqnbSPDmzHEg
         ADRA==
X-Gm-Message-State: AOAM532MqNiHN8b/guEkgSUSYXzblwUpSqF4rjNV5eGNWwvv65U3Cjqn
        AZGLdFvBiCxRD1wTgYVtLmpI3e7epo3k7PXx
X-Google-Smtp-Source: ABdhPJydwoFGLZgcz4NmuS/ionLpQBPtHiioJnqmd0mjxHWgfmJTXxpQKkwIkBWtrUrCPm/y2MEKAw==
X-Received: by 2002:a17:902:930b:b0:14d:b0c0:1f71 with SMTP id bc11-20020a170902930b00b0014db0c01f71mr20409658plb.113.1646787507899;
        Tue, 08 Mar 2022 16:58:27 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004e136d54a15sm298627pfv.105.2022.03.08.16.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 16:58:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
In-Reply-To: <20220308055200.735835-1-hch@lst.de>
References: <20220308055200.735835-1-hch@lst.de>
Subject: Re: move more work to disk_release v4
Message-Id: <164678750695.407482.16938028641587368987.b4-ty@kernel.dk>
Date:   Tue, 08 Mar 2022 17:58:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Mar 2022 06:51:46 +0100, Christoph Hellwig wrote:
> this series resurrects and forward ports ports larger parts of the
> "block: don't drain file system I/O on del_gendisk" series from Ming,
> but does not remove the draining in del_gendisk, but instead the one
> in the sd driver, which always was a bit ad-hoc.  As part of that sd
> and sr are switched to use the new ->free_disk method to avoid having
> to clear disk->private_data and the way to lookup the SCSI ULP is
> cleaned up as well.
> 
> [...]

Applied, thanks!

[01/14] blk-mq: do not include passthrough requests in I/O accounting
        commit: 00baefa025651b33a67fefcf8f6bf527af7b085f
[02/14] blk-mq: handle already freed tags gracefully in blk_mq_free_rqs
        commit: abcc148ab9236abce466d5e5070f43d290cf72c7
[03/14] scsi: don't use disk->private_data to find the scsi_driver
        commit: b55ac66299345b24a81444d9222bf0362920b829
[04/14] sd: rename the scsi_disk.dev field
        commit: 695a5b27e06242cfc89988d342016697c5f5ab5f
[05/14] sd: call sd_zbc_release_disk before releasing the scsi_device reference
        commit: a22da9716c1375b8c0563b607cacdb422680233b
[06/14] sd: delay calling free_opal_dev
        commit: f3ca592e32b3b7a74a57b77bf24cdefff1ea53fc
[07/14] sd: implement ->free_disk to simplify refcounting
        commit: d31ece5f112968d7efe70fdffa4d39ed6b876f40
[08/14] sr: implement ->free_disk to simplify refcounting
        commit: 719468c6d02fdc1a17d7b40ec73cec155cf05945
[09/14] block: move blkcg initialization/destroy into disk allocation/release handler
        commit: 754ddb47bbc48c987cd3c718a1ee9f1d83c001f7
[10/14] block: don't remove hctx debugfs dir from blk_mq_exit_queue
        commit: f58dfe31e0cd242f1de93d1aad0fbe8af7a09dc2
[11/14] block: move q_usage_counter release into blk_queue_release
        commit: 5407dfa49e67160724567e565fa58086a3ec1b8c
[12/14] block: move blk_exit_queue into disk_release
        commit: 0f426c2c2c7ea134562e64d7b6ce0acaef67146e
[13/14] block: do more work in elevator_exit
        commit: 3e8f2f0ef1000649dbc7d0dd41c714617a1dbc9c
[14/14] block: move rq_qos_exit() into disk_release()
        commit: 641fde02765e74b8b5ae8426a02c21abf0ce3a29

Best regards,
-- 
Jens Axboe


