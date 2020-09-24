Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BBDC4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B0723600
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 10:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fb5sAyVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIXK1j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:27:39 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29046 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgIXK1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 06:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600943259; x=1632479259;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VJUxKkMgAakbT3L/fC0FIlc1ypeBbbtBZnjUiDl52NU=;
  b=fb5sAyVCrxy+m4pUK3gJZNPiyH7ZBuNt7jXfNRy2TnH4dYY8VsFS/jWh
   xgo4Z4a9Q7U5+gQx1N+U0cPQXI2s0DMjrOmSBgN/8Nc9DxhMmEErwDHM6
   h3J7z2L4677ZRxYipY4ur3IMu3p+S568yhS5ko0fs0HOxUAYGisxB8ACX
   o=;
X-IronPort-AV: E=Sophos;i="5.77,297,1596499200"; 
   d="scan'208";a="78889262"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 24 Sep 2020 10:27:37 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id A14B3A1FF9;
        Thu, 24 Sep 2020 10:27:36 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.244) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Sep 2020 10:27:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent grants
Date:   Thu, 24 Sep 2020 12:27:14 +0200
Message-ID: <20200924102714.28141-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200924101344.GN19254@Air-de-Roger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.244]
X-ClientProxiedBy: EX13D40UWC004.ant.amazon.com (10.43.162.175) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 24 Sep 2020 12:13:44 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Wed, Sep 23, 2020 at 04:09:30PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Tue, Sep 22, 2020 at 09:01:25AM +0200, SeongJae Park wrote:
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > Persistent grants feature provides high scalability.  On some small
> > > systems, however, it could incur data copy overhead[1] and thus it is
> > > required to be disabled.  But, there is no option to disable it.  For
> > > the reason, this commit adds a module parameter for disabling of the
> > > feature.
> > 
> > Would it be better suited to have it per guest?
> 
> I think having a per-backend policy that could be specified at the
> toolstack level would be nice, but I see that as a further
> improvement.

Agreed.

> 
> Having a global backend domain policy of whether persistent grants are
> enabled or not seems desirable, and if someone wants even more fine
> grained control this change is AFAICT not incompatible with a
> per-backend option anyway.

I think we could extend this design by receiving list of exceptional domains.
For example, if 'feature_persistent' is True and exceptions list has '123,
456', domains of domid 123 and 456 will not use persistent grants, and vice
versa.

I could implement this, but... to be honest, I don't really understand the
needs of the fine-grained control.  AFAIU, the problem is 'scalability' vs
'data copy overhead'.  So, only small systems would want to turn persistent
grants off.  In such a small system, why would we need fine-grained control?
I'm worrying if I would implement and maintain a feature without real use case.

For the reason, I'd like to suggest to keep this as is for now and expand it
with the 'exceptions list' idea or something better, if a real use case comes
out later.


Thanks,
SeongJae Park
