Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88DFC2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 08:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01902239E5
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 08:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVIPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 04:15:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50925 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgIVIPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 04:15:55 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 04:15:54 EDT
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25E985803A0;
        Tue, 22 Sep 2020 04:08:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=+sAu8ps52bLSAa5FgjUvW8bW6P
        OzBijBGCvyvIRLYyQ=; b=B2VD8M1N3d7S0lxNURdeocMfx0KFMxkyjZd9+ogUs3
        v5EGjN83aJkbD2cs1I9VrLs0KZK34p2QjhW/ZZ4VGZhCpcqv6T4ibteBHhzKXfWK
        W83OhDJPQtjKOEoWntqfRge5GAGPa09ZN9MNVrxS5nQ9o/PYLNQe3sJCQqbqignM
        UbS4VVQSNYbE/pO7xF4bAG9eWQ0S56CblxZszCaF6vZiEVO1++Z0ug8QKu38VjML
        XEI+Nirh7eGIu0Xo32e9Z7vrlhR0/xwymbVe2QAJcZT5SnkwLj3SckKcdKlG6CAy
        Zy0nZvSAOVXq9b3WUZEiX/qzsglqpRxTfaHF+65rDGLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+sAu8ps52bLSAa5Fg
        jUvW8bW6POzBijBGCvyvIRLYyQ=; b=VW7ADeXGd8yL51lLndaDt+LJIkLV5BPP+
        vxraHiUjW3JxVqUddU2X/mqL7q65UyPNek3UfC0lLF+OzAtXI08NhQncgFAtc4iH
        4oOx1BD0ZAEYXeOI4DxcjQWhi5Tk8OFFFySQJgC7K8gyKk84uHX2Wsokhm193JF/
        I/SIu3dTfbGdZMwl2DpfYpx7TZQ1WwnFSrFddFJnO2BvCW68Gb2nmEZcG4gojNs0
        b9i04usBjlkayEmkXcjTlCCyFpqPBvoh+Gp2uf21OjF9MMDBaU4qOImF0tfUo4fT
        b1YwfwWO1srCCJKCNsIJz+M8QCEFQQJ5aky6B2s6TR/vgC1It9mdQ==
X-ME-Sender: <xms:ELFpX6_DeQkqKyY1_ZDCKPHMj0MeGPpMCwivsOlSkhS0TjyKHBLrLA>
    <xme:ELFpX6un8d1v5LDnmhkYatCEDb-FhNODTffszEp1-RPpiu7p12YYPBKmA7EJocrs7
    YRJlH0Ma-Ao5v0jjxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
    nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
    epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
    kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:ELFpXwBejG-V8hiHUBz7GW2_9kkhWXM6ql3fZhLyIKWXN3yj9g6W2w>
    <xmx:ELFpXydyG4igvXU4NNrZOmakMZOE1Zqt6Vx_S3RaN8xcA5QgLnQdEg>
    <xmx:ELFpX_NoduZ9MU0-ofxOqwL7XKuyUNG0CXwmpfAG45FTQqy_h03LtA>
    <xmx:EbFpX4aBXBVrgnJ7LyktAscz0_B-WGPcklBquV1MMaCg_MEN5BlpGQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC4ED306467E;
        Tue, 22 Sep 2020 04:08:47 -0400 (EDT)
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktests] block/011: remove and rescan for evicted device
Date:   Tue, 22 Sep 2020 10:08:43 +0200
Message-Id: <20200922080843.1249290-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

Devices that actually honor the Bus Master Enable bit and considers the
resulting failure to read/write a fatal error, often ends up getting
disabled by the kernel when running block/011.

Remove the device and rescan the pci bus after completing the test to
make sure we bring the device back up if required.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 tests/block/011 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/block/011 b/tests/block/011
index 4f331b4a7522..f1306ae3896f 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -22,6 +22,7 @@ test_device() {
 	echo "Running ${TEST_NAME}"
 
 	pdev="$(_get_pci_dev_from_blkdev)"
+	sysfs="/sys/bus/pci/devices/${pdev}"
 
 	if _test_dev_is_rotational; then
 		size="32m"
@@ -42,4 +43,8 @@ test_device() {
 	done
 
 	echo "Test complete"
+
+	# bring the device back up if it was disabled by the kernel
+	echo 1 > "${sysfs}/remove"
+	echo 1 > /sys/bus/pci/rescan
 }
-- 
2.28.0

