Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE19C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06B206BA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vcrafkA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfAIPdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:33:41 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11926 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfAIPdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:33:41 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190109153338epoutp033e1a8d4f92ebff06ef93949804004170~4N-nPBSCe3068430684epoutp03V;
        Wed,  9 Jan 2019 15:33:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190109153338epoutp033e1a8d4f92ebff06ef93949804004170~4N-nPBSCe3068430684epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547048018;
        bh=epx2bnJrUEuff/WcKh3w2qFRZarWKsQXniPc8QtJDU8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=vcrafkA3wnOa4ahipKIyiFV/+Rv/+SCh/lKqBu5MnFoORfT78aviWxpueT7UOCgbR
         dHkTq3ApE2/JN6pFiYhj0xDFcq3KL7Vv96bxdgjHKQr3mYC9BzgSxkMHa/E5REzSO4
         EmCraXWqx9SUbOt0u0cVIoOMJ32sOI7Hrx203KkU=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190109153337epcas2p24a66f600d22bf42496d9aad4668b65db~4N-mR3aAd2607426074epcas2p2G;
        Wed,  9 Jan 2019 15:33:37 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.D1.04062.054163C5; Thu, 10 Jan 2019 00:33:36 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf~4N-l3nmYp0300403004epcas2p2m;
        Wed,  9 Jan 2019 15:33:36 +0000 (GMT)
X-AuditID: b6c32a47-30fff70000000fde-0f-5c3614506338
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.6D.03627.054163C5; Thu, 10 Jan 2019 00:33:36 +0900 (KST)
Received: from test-PowerEdge-R720.sa.corp.samsungelectronics.net
        ([107.108.221.212]) by mmp1.samsung.com (Oracle Communications Messaging
        Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PL2000VLLVH1220@mmp1.samsung.com>; Thu, 10 Jan 2019 00:33:36 +0900 (KST)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nvme@lists.infradead.org, jack@suse.com, david@fromorbit.com,
        tytso@mit.edu, prakash.v@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/4] fs: introduce four macros for in-kernel hints
Date:   Wed, 09 Jan 2019 21:00:59 +0530
Message-id: <1547047861-7271-3-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCmuW6AiFmMwaZzNhZbjt1jtHi+fDGj
        xdH/b9ks9t7Stpg57w6bxZ69J1ks5i97ym5xZcoiZovWnp/sDpwepxZJeGxeUu/RdOYos0ff
        llWMHuu3XGXx+LxJLoAtissmJTUnsyy1SN8ugStj5X3Jgr1sFXved7E2MG5i7WLk4JAQMJFY
        +dmmi5GTQ0hgB6PEqhlFXYxcQPZ3RokHx6ewgiRAaqafO8cGkdjNKNE7dwMThDOdSWLtzGNM
        IJPYBDQlLkwuBTFFBBQlLr93AilhFjjHKLH040QmkEHCAk4SC78eYwOxWQRUJT7+/QJm8wLF
        pxxcxw6xTE7i5rlOZhCbU8BZ4lfPT2aQQRICc9gkjt24wAhxtYvE609CEPXCEq+Ob4HqlZZ4
        tmojI4RdLPHrzlGo3g5GiesNM1kgEvYSF/f8BTuIWYBPouPwX3aImbwSHW1CEKaHRN8UXYgX
        pzFKTH9/n2kCo+QCRoZVjGKpBcW56anFRgXGesWJucWleel6yfm5mxjB0ajlvoNx2zmfQ4wC
        HIxKPLw7GMxihFgTy4orcw8xSnAwK4nwqt8xiRHiTUmsrEotyo8vKs1JLT7EKM3BoiTO+1B6
        brSQQHpiSWp2ampBahFMlomDU6qBMftrssrWOM8uj50uXOaTtOa/mXxBaOuMxoAH5+5/2Jqx
        duW7Gb/ahFg4bZ/N3Pnj7tNqRi2PQ+9sbf1lYr2X6B4Okc1u27mdp2a1fd/FW50b8vjMKrLr
        13+8lfme86x1wK4yjlXPbSp9Vom2yi2tqXnj/Gf+10PVvnvv6AdqiPh9YFijyHrqtBJLcUai
        oRZzUXEiANMjEs3CAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsVy+t9jAd0AEbMYg82TFCy2HLvHaPF8+WJG
        i6P/37JZ7L2lbTFz3h02iz17T7JYzF/2lN3iypRFzBatPT/ZHTg9Ti2S8Ni8pN6j6cxRZo++
        LasYPdZvucri8XmTXABbFJdNSmpOZllqkb5dAlfGyvuSBXvZKva872JtYNzE2sXIySEhYCIx
        /dw5ti5GLg4hgZ2MEktO3WeEcGYySZxZ1sTexcjBwSagKXFhcimIKSKgKHH5vRNICbPAOUaJ
        6zc6mEEGCQs4SSz8eowNxGYRUJX4+PcLmM0LFJ9ycB07xDI5iZvnOsHqOQWcJX71/ASzhYBq
        Lt66yjaBkWcBI8MqRsnUguLc9NxiowKjvNRyveLE3OLSvHS95PzcTYzA0Np2WKt/B+PjJfGH
        GAU4GJV4eBP+mcYIsSaWFVfmHmKU4GBWEuFVv2MSI8SbklhZlVqUH19UmpNafIhRmoNFSZyX
        P/9YpJBAemJJanZqakFqEUyWiYNTqoFxt93nqMNbEqYV9UzS3lHlfrTf6kHH+ruWsixTg64K
        5wafETr6fhXnlu5r+mFXT94XW3nmuWNph57v8l9fLFd8aHKdsIjrVlCS9u692z+9cfCp332c
        1Vhh8+VnKtcE/+7bdyw0LtWM8Ydm91KpLY8eOP3/mze/44h326fHrbYyFhN6L3L+4L3zSYml
        OCPRUIu5qDgRACgmQ3MpAgAA
X-CMS-MailID: 20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
        <CGME20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf@epcas2p2.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Exiting write-hints are exposed to user-mode. There is a possiblity
of conflict if kernel happens to use those. This patch introduces four
write-hints for exclusive kernel-mode use.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c777..e8548eb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -291,6 +291,11 @@ enum rw_hint {
 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+/* below ones are meant for in-kernel use */
+	KERN_WRITE_LIFE_SHORT,
+	KERN_WRITE_LIFE_MEDIUM,
+	KERN_WRITE_LIFE_LONG,
+	KERN_WRITE_LIFE_EXTREME
 };
 
 #define IOCB_EVENTFD		(1 << 0)
-- 
2.7.4

