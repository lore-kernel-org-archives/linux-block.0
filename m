Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66059C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 20:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6C323E26
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 20:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbgLJUwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 15:52:37 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48743 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390239AbgLJUwb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 15:52:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 95EEA762;
        Thu, 10 Dec 2020 15:51:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 10 Dec 2020 15:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:subject:message-id:mime-version:content-type; s=
        fm3; bh=lWzbyUMwIInFGZ0ycd3q3D6LtNvaqjxYZRltD3m5T98=; b=KgR+4NZ4
        GwNmQNCuBW+MQuPr6TSlLOTxtUhsFUQVB5pVP89BVwGE4R7kgx5Obfij9lODPbBq
        1tyd0gXMpm0ipHa9x2Rp7rnQKCauXYzNIKPNpI1GMt78ePXKsGHYMsWnDHehX/tX
        Wds1HU3L2Dd7KTPuSEfacQkDntSMyCASyCUs3hk4XAf4ZjJfolrFoFCRc7uvdkcu
        mw1VxLyfv/hfQc9ObG+2hHUDmIOhSmRh7I3AWLBCorvQCGSMp+cSgIn9URr30TPK
        ztar83tEHtC/IImLpnhMLLFrMG96ZjxVvf3WsItckWPfD+RLxbnuWrTSNa7rI7nA
        8HBY8vzrt6NFLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=lWzbyUMwIInFGZ0ycd3q3D6LtNvaq
        jxYZRltD3m5T98=; b=bOw6PnShdqSAPsJMlizkmehhnYK2WJDFDb4Z/wTnrRc+u
        8lRIkcipFWXXpp2+BA9Ty3Dy17GGDssirVPxzF/hLArviOnJlFS59IRlPOOKeJAg
        f4qmOEvc3DhSbUsBqiAC+NDMPvJFW2hp28zvqOUQugLOy9QoaNnZ+ocjqfo+ZpcY
        7D2O4byEYwRPiFYQktEK2qJRdtEI9ifWIObewoZgdPlnceqS21QDmwSdBVh4cSJY
        n6ghvdwz4iXtr1WotfbLuXHBpa5moCKJAv3OThs8TIR+2EqTfct/CRzIegm3WKqi
        aKeya9+norUIBiaDGWO1Fn2qL+nlscrTADiuLPGfA==
X-ME-Sender: <xms:XorSX3_UMG8o_nfUkfQYjzDwrsk3WYhJ_Jjol9wnrUBE5cr42t_r7A>
    <xme:XorSXzuwvoX8bQqFbklUYDTKYR5opzv5F6ptS9pv1uD3TX6tsfuDDacgADZp2dtaR
    gpO2ziChHFp2Q_7FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudektddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepiedvieelgeeuuedtfeduhfefteehhfevvdeljeetgfeugfdtledtudetvdeh
    keffnecukfhppeeijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vg
X-ME-Proxy: <xmx:XorSX1BjSty62HZDs-aLy0k-3acBO1e8p0Oz0fvwJCt7Zx8uvkMGmQ>
    <xmx:XorSXzeVidO12CIOFDEnS1gu5VQgXmzqUuje7AU2v9q2yiRZlB_FKw>
    <xmx:XorSX8O2myoxJVtuZUHpmUUUqlZItdoj-q1LybvExcnCJit5Ca7e1Q>
    <xmx:X4rSX3aPVDqEZkVz6bsMOrjPp3YJPlF7nsc0tfkwiqWBmCj4yJcx6g>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id C63A4240057;
        Thu, 10 Dec 2020 15:51:42 -0500 (EST)
Date:   Thu, 10 Dec 2020 12:51:41 -0800
From:   Andres Freund <andres@anarazel.de>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: hybrid polling on an nvme doesn't seem to work with iodepth > 1 on
 5.10.0-rc5
Message-ID: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

When using hybrid polling (i.e echo 0 >
/sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
an iodepth > 1. Sometimes fio hangs, other times the performance is
really poor. I reproduced this with SSDs from different vendors.


$ echo -1 | sudo tee /sys/block/nvme1n1/queue/io_poll_delay
$ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 1
93.4k iops

$ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32
426k iops

$ echo 0 | sudo tee /sys/block/nvme1n1/queue/io_poll_delay
$ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 1
94.3k iops

$ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32
167 iops
fio took 33s


However, if I ask fio / io_uring to perform all those IOs at once, the performance is pretty decent again (but obviously that's not that desirable)

$ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32 --iodepth_batch_submit=32 --iodepth_batch_complete_min=32
394k iops


So it looks like there's something wrong around tracking what needs to
be polled for in hybrid mode.

Greetings,

Andres Freund
