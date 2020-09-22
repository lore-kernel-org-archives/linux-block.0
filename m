Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57720C4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A1A23A1B
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KGOFFgy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVPDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:03:22 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:57183 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgIVPDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 11:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600787001; x=1632323001;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=eRDTrtuN85IXUqjdLp1BB4IHHjXsWG5mm0q8q4Un7ZA=;
  b=KGOFFgy9HvG1RXo0U04xoIFJum581aoyB44eWgLeZpIB7H/f6GZhoUal
   478+5nVoD2s4XvJlfZ6eeouCvlz/AJq/7O0kHaMhb65fClKVzqwnzLPlr
   mAjsANk21X7bd8fUaERcGUln0DCgIwIUbrVF7xooIh7IKdUY4BW1RHyBn
   4=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="56981745"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Sep 2020 15:03:18 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id A6C051A00BF;
        Tue, 22 Sep 2020 15:03:17 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.145) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 15:03:10 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
        SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] xen-blkfront: Apply changed parameter name to the document
Date:   Tue, 22 Sep 2020 17:02:55 +0200
Message-ID: <20200922150255.5850-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200922144425.GL19254@Air-de-Roger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D47UWA001.ant.amazon.com (10.43.163.6) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Sep 2020 16:44:25 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Tue, Sep 22, 2020 at 04:27:39PM +0200, Jürgen Groß wrote:
> > On 22.09.20 16:15, SeongJae Park wrote:
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > Commit 14e710fe7897 ("xen-blkfront: rename indirect descriptor
> > > parameter") changed the name of the module parameter for the maximum
> > > amount of segments in indirect requests but missed updating the
> > > document.  This commit updates the document.
> > > 
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > 
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> Does this need to be backported to stable branches?

I don't think so, as this is not a bug affecting users?


Thanks,
SeongJae Park
