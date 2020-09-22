Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F591C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BD32396D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z+jhQ3zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIVOwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:52:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25453 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgIVOwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600786371; x=1632322371;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=T9Oqjy4Aak9yvrDD8pdwIk5ZvPiudTMfoePpU2Nlp48=;
  b=Z+jhQ3zrac0xjEd+3UCzosyOHRc6xBQjlc/bu72xy+H/wKbbvyA8CiJp
   WVMv1XBbt2VBOUyGmjd9/DkxDnP7hj9GtysJu96+8eM2GYQMNZ5CG9V23
   4hnvZI5vFC4UHpclxgB+yM5RBRytLfyEp8ocsua5QAHUgUkgYYL7hdBtQ
   s=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="78282518"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Sep 2020 14:52:47 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 9F408A18FB;
        Tue, 22 Sep 2020 14:52:44 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.137) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 14:52:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        <jgross@suse.com>, SeongJae Park <sjpark@amazon.de>,
        <axboe@kernel.dk>, <aliguori@amazon.com>, <amit@kernel.org>,
        <mheyne@amazon.de>, <pdurrant@amazon.co.uk>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] xen-blk(back|front): Let users disable persistent grants
Date:   Tue, 22 Sep 2020 16:52:21 +0200
Message-ID: <20200922145221.3131-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200922144556.GM19254@Air-de-Roger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.137]
X-ClientProxiedBy: EX13P01UWB001.ant.amazon.com (10.43.161.59) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Sep 2020 16:45:56 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Tue, Sep 22, 2020 at 04:15:46PM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Persistent grants feature provides high scalability.  On some small
> > systems, however, it could incur data copy overheads[1] and thus it is
> > required to be disabled.  But, there is no option to disable it.  For
> > the reason, this commit adds module parameters for disabling of the
> > feature.
> 
> With the changes requested by Jürgen you can add my:
> 
> Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thank you for your kind and helpful reviews!


Thanks,
SeongJae Park
