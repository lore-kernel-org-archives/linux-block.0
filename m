Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D4C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCC220856
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNKcV8rG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfAQP31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:29:27 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40086 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfAQP31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 10:29:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so11689980qtf.7;
        Thu, 17 Jan 2019 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1q9JcQzfXCyTHN8xEENUcIAYmg2fHESb/RPq3VsRrmY=;
        b=KNKcV8rGGm3ft/hCosy6yKw8HejebNF0+qFVCsIl0msAI9t35IT7w2cYV5lF9Pgyeq
         g8NT/0Srx1tUMm7vhL/5mfVK9c6Cq7RLUEZpX+XLadE4g4ggX9ggplBobmehHEMo5J86
         pmv1mxp+IZEznqecjT/QtwOBGRvspEd66lpFu1j7zWSpqhDdmD4hdhGmhoGdQ1fxZGKh
         1STqKno5w0PNYKpK1u3JZzr5xs/OS3Wes/OVzUC9h9tiERyzmL1neiWjnfHU9sx9JJBB
         hMz83wqjIKg84Fht+1BY5AKF7ajwaKGU9XyVBIkbj9Zdfg/vePAupohuVzMK9NPJacOv
         DtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1q9JcQzfXCyTHN8xEENUcIAYmg2fHESb/RPq3VsRrmY=;
        b=L1gE+NCg/vM7vnfb7q7V6bj2/tJCvw8NbNrbxxBwXJ8KnDkehDn2bC7QXGf+9kiBlJ
         h+uSLgyG7rZDjSGY7tnSKzlqy0kMLziN5XjfgaD06osxDkmwAPYZXYmKUa1ESRa85Zxa
         9V7v5pO5jnV3x9r9xY2DtKdKOK5Er5L8ADywrRYGr4Pz02CsK5NpS8QzB0XHkBRWarCQ
         wj295EjqBf5F8WQMgKH44pWDtH1TWuKbvZAueOsgrimGy5KLkcWemo+r4uuisyrPF7BP
         dKMFcTjfrgj+oO77P68IlbFgnhAsKiCKrmvx+ZYKT8HYpptAnSbIxVP/DAc4Pgs0ubBw
         nozg==
X-Gm-Message-State: AJcUukdNfrot1pLhcq/y22vAk/xKWbTWIDB8Xe+Bs/DsKFtu1mHrxpbt
        yPXVZxKv0BCvZ7Hw+VUf32I=
X-Google-Smtp-Source: ALg8bN7719gK8HKltZETIMhi3ikam+Q5tzFe4BGnczduIbW21flkO9npy1NbKol8LRW1pPxaFI6rYg==
X-Received: by 2002:aed:2dc5:: with SMTP id i63mr12227248qtd.173.1547738965969;
        Thu, 17 Jan 2019 07:29:25 -0800 (PST)
Received: from localhost.localdomain (198-0-156-163-static.hfc.comcastbusiness.net. [198.0.156.163])
        by smtp.gmail.com with ESMTPSA id l4sm6574411qtf.22.2019.01.17.07.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:29:25 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:29:23 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Paul.Durrant@citrix.com, konrad.wilk@oracle.com
Subject: Re: [Xen-devel] [PATCH v6 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20190117152919.GA26079@localhost.localdomain>
References: <1547484104-20625-1-git-send-email-dongli.zhang@oracle.com>
 <1547484104-20625-2-git-send-email-dongli.zhang@oracle.com>
 <20190115082036.y7svi3xz3dkqd4w4@mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115082036.y7svi3xz3dkqd4w4@mac>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 09:20:36AM +0100, Roger Pau Monné wrote:
> On Tue, Jan 15, 2019 at 12:41:44AM +0800, Dongli Zhang wrote:
> > The xenstore 'ring-page-order' is used globally for each blkback queue and
> > therefore should be read from xenstore only once. However, it is obtained
> > in read_per_ring_refs() which might be called multiple times during the
> > initialization of each blkback queue.
> > 
> > If the blkfront is malicious and the 'ring-page-order' is set in different
> > value by blkfront every time before blkback reads it, this may end up at
> > the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> > xen_blkif_disconnect() when frontend is destroyed.
> > 
> > This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> > once.
> > 
> > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> LGTM:
> 
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Applied.

Will push out to Jens in a couple of days. Thank you!
> 
> Thanks!
