Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A18C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 20:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DB821721
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 20:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBGUPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:15:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:15899 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfBGUPi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 15:15:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 12:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="145048626"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2019 12:15:37 -0800
Date:   Thu, 7 Feb 2019 13:15:09 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk
Subject: Re: [PATCH 05/18] Add io_uring IO interface
Message-ID: <20190207201508.GA31594@localhost.localdomain>
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207195552.22770-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 07, 2019 at 12:55:39PM -0700, Jens Axboe wrote:
> IO submissions use the io_uring_sqe data structure, and completions
> are generated in the form of io_uring_sqe data structures. 
                                        ^^^

Completions use _cqe, right?
