Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5073C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B86206BA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YRQbvR8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfAIPdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:33:33 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11904 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfAIPdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:33:32 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190109153330epoutp032fd5ea9b75aa5604ea01a598025debff~4N-fzeiXT3068430684epoutp03S;
        Wed,  9 Jan 2019 15:33:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190109153330epoutp032fd5ea9b75aa5604ea01a598025debff~4N-fzeiXT3068430684epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547048010;
        bh=UmHmkE2620GBxCzOvQOBJNl4cT+yi2heu2GHx2lhi4A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YRQbvR8Ib4DQ4xmtpVZCDpsCJJhM1WA2XKBiEke2dUY6nUmft2FBIuqicALmSTHv4
         4DPulz73SemExmUqtWl9qIq7VCNYFhsjCWSXxa5kgABY4DHC4r7eXG1N3T/UNHCWoz
         3rxP4rOhXsJ88GmSWlhHTIKss6wT0kykZAi4pXFE=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190109153329epcas2p488f4dbd867165110c13594b33e8aacd5~4N-fRZn-h0641506415epcas2p4o;
        Wed,  9 Jan 2019 15:33:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.40.04055.944163C5; Thu, 10 Jan 2019 00:33:29 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17~4N-eI2r030641106411epcas2p4k;
        Wed,  9 Jan 2019 15:33:28 +0000 (GMT)
X-AuditID: b6c32a45-711ff70000000fd7-37-5c361449d2b8
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.6D.03627.844163C5; Thu, 10 Jan 2019 00:33:28 +0900 (KST)
Received: from test-PowerEdge-R720.sa.corp.samsungelectronics.net
        ([107.108.221.212]) by mmp1.samsung.com (Oracle Communications Messaging
        Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PL2000VLLVH1220@mmp1.samsung.com>; Thu, 10 Jan 2019 00:33:28 +0900 (KST)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nvme@lists.infradead.org, jack@suse.com, david@fromorbit.com,
        tytso@mit.edu, prakash.v@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 0/4] Write-hint for FS journal
Date:   Wed, 09 Jan 2019 21:00:57 +0530
Message-id: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCmua6niFmMwd6zUhZbjt1jtHi+fDGj
        xdH/b9ks9t7Stpg57w6bxZ69J1ks5i97ym5xZcoiZovWnp/sDpwepxZJeGxeUu/RdOYos0ff
        llWMHuu3XGXx+LxJLoAtissmJTUnsyy1SN8ugStj9aZ9zAUzeStO919la2B8xd7FyMkhIWAi
        saPrFnMXIxeHkMAORol3KyexQjjfGSU+bzoB5HCAVfVtZIKI72aUOHX7AyOEM51JYseXf2BF
        bAKaEhcml4KYIgKKEpffO4GUMAucY5RY+nEiE8g2YQFDidk/XoBtZhFQlXi5dwoLiM0r4CQx
        v3sTG8RFchI3z3WCXSQh0MEm0fFsLhNEwkXiy/orjBC2sMSr41ugXpCWeLZqI1S8WOLXnaMw
        zYwS1xtmskAk7CUu7vkLNohZgE+i4/BfdojPeCU62oQgTA+JD781QCqEBGIlOr8tYpzAKLGA
        kWEVo1hqQXFuemqxUYGhXnFibnFpXrpecn7uJkZw5Gm57mCccc7nEKMAB6MSD2/CP9MYIdbE
        suLK3EOMEhzMSiK86ndMYoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzPpKeGy0kkJ5YkpqdmlqQ
        WgSTZeLglGpgfOz77L/Psrnz+hTuLn3Ns+Va2LIpL3ZLzHoxY3bcfTf1J8e+PD9k3mumq/ts
        0k+/qInV8qKzbkx4WxG6VP747cVas365n5V9M3/jjmeKRpUWP1d8kN4xi99ccUq0+jlj5seq
        5aFHxD0NpK7fajbu7kqdkhawV2QHd17zsZsLFJ/dX77uqtOJaZOVWIozEg21mIuKEwFFbOQ2
        uAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsVy+t9jAV0PEbMYg+uNPBZbjt1jtHi+fDGj
        xdH/b9ks9t7Stpg57w6bxZ69J1ks5i97ym5xZcoiZovWnp/sDpwepxZJeGxeUu/RdOYos0ff
        llWMHuu3XGXx+LxJLoAtissmJTUnsyy1SN8ugStj9aZ9zAUzeStO919la2B8xd7FyMEhIWAi
        0beRqYuRi0NIYCejxPPJExkhnJlMEj3PZrKAFLEJaEpcmFwKYooIKEpcfu8EUsIscI5R4vqN
        DuYuRk4OYQFDidk/XrCD2CwCqhIv905hAbF5BZwk5ndvYgOxJQTkJG6e62SewMi1gJFhFaNk
        akFxbnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYKhsO6zVv4Px8ZL4Q4wCHIxKPLwJ/0xjhFgT
        y4orcw8xSnAwK4nwqt8xiRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUg
        tQgmy8TBKdXA2PyB2+xwkkLDo3/BgX+21h179aNZ6rHTSr1TE86v3imyn+9ksYvM37p9z+Mc
        zRXjLau+F6sYzVo044Vt4BauA5Hrf0/ZZtmaLLRmh/FbAQlhz9DXTVd6fNb3enU4nGyKm/E9
        7r5+9gO+V6f02baGzN3R9Vp66+TzN7uW1MsZn0jLzE+YFCzyWImlOCPRUIu5qDgRAAAE5agR
        AgAA
X-CMS-MailID: 20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Towards supporing write-hints/streams for filesystem journal.                   
                                                                                
Here is the v1 patch for background -                                           
https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2                        
                                                                                
Changes since v1:                                                               
- introduce four more hints for in-kernel use, as recommended by Dave chinner   
  & Jens axboe. This isolates kernel-mode hints from user-mode ones.            
- remove mount-option to specify write-hint, as recommended by Jan kara &       
  Dave chinner. Rather, FS always sets write-hint for journal. This gets ignored
  if device does not support stream.                                            
- Removed code-redundancy for write_dirty_buffer (Jan kara's review comment)


Kanchan Joshi (4):
  block: Increase count of supported write-hints
  fs: introduce four macros for in-kernel hints
  fs: introduce APIs to enable sending write-hint with buffer-head
  fs/ext4,jbd2: add support for passing write-hint with journal.

 fs/buffer.c                 | 18 ++++++++++++++++--
 fs/ext4/super.c             |  2 ++
 fs/jbd2/commit.c            | 11 +++++++----
 fs/jbd2/journal.c           |  3 ++-
 fs/jbd2/revoke.c            |  3 ++-
 include/linux/blkdev.h      |  5 ++++-
 include/linux/buffer_head.h |  3 +++
 include/linux/fs.h          |  5 +++++
 include/linux/jbd2.h        |  8 ++++++++
 9 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.7.4

