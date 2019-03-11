Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BCC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D992E2084F
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552322648;
	bh=8ZFIfxk4TUfG+wtdp/wxEwQASMaWol79eD0kznV608s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SUWtInmAkpDotB84R7Rr47rxZGo7dTbbAk3C09os5i1m3xv+z+/4ian8V5kyDwBtA
	 CqrrEkBJPq9OKVTaUMATPfgHLRzRGxlcpaoOCu/GqnxLjwOJNimGlbTzvPIGVUH0mS
	 oH5sOBGfmj/FeHnDziWn7Y9B/mLLHaXKcgQpqGbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCKQoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:44:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:58385 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfCKQoH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 12:44:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 09:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306249001"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 09:44:06 -0700
Date:   Mon, 11 Mar 2019 10:44:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH fio] t/io_uring: add depth options
Message-ID: <20190311164444.GC10411@localhost.localdomain>
References: <20190308215959.5575-1-keith.busch@intel.com>
 <05f6756f-2298-5f88-1f44-6c6d11a82e29@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f6756f-2298-5f88-1f44-6c6d11a82e29@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 09:31:02PM -0700, Jens Axboe wrote:
> On 3/8/19 2:59 PM, Keith Busch wrote:
> > Make depth options command line parameters so a recompile isn't
> > required to see how it affects performance.
> 
> Thanks, everything really should be command line options. But I never
> bothered, it wasn't mean to live this long :-)

It's a nice convenient way to do some quick and light benchmarking,
so we've been finding it very useful.

But I totally rushed this patch and just sent it once I heard it "worked",
and it really doesn't because malloc doesn't zero the buffer. My mistake,
kzalloc spoiled me. Here's the fix:

---
diff --git a/t/io_uring.c b/t/io_uring.c
index 36aede9b..363cba3e 100644
--- a/t/io_uring.c
+++ b/t/io_uring.c
@@ -526,7 +526,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	submitter = malloc(sizeof(*submitter) * depth * sizeof(struct iovec));
+	submitter = malloc(sizeof(*submitter) + depth * sizeof(struct iovec));
+	memset(submitter, 0, sizeof(*submitter) + depth * sizeof(struct iovec));
 	s = submitter;
 
 	flags = O_RDONLY | O_NOATIME;
--
