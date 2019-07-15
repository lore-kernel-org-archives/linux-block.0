Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2914EC7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095D02064B
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfGOKn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:43:57 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:61349 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfGOKn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 06:43:57 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 06:43:57 EDT
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: Pgm/UNT/R6e5AUfaKfE5m6EKWEYn2DqPlSy8urRB+oeHpISgw3aIjI+fKlvkOTxjLL7cNxAwhq
 AXtEXcP/rBMWyPn47gY7iEk1KRYpl8Ac2KhKRCUc7qwbgb/W55FlOBBlqBXgKz4DIBaQ+1pUma
 y/aRKqTA8yy+J79JrXeSk83q8Uv4Mdo3g5RCkI3u0QViWbClbpb+uz0iSnsrWBVKDY1/XJo1y3
 7tGcYswO/EHZSGHAb3qv2xZGu2Tfbht++e1zi1ChSDIoevZHQZTihEmcK53b0W0TlBXKXT5dhu
 R7E=
X-SBRS: 2.7
X-MesageID: 2991308
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,493,1557201600"; 
   d="scan'208";a="2991308"
Date:   Mon, 15 Jul 2019 12:36:40 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
CC:     <linux-block@vger.kernel.org>, <colyli@suse.de>,
        <linux-bcache@vger.kernel.org>, <linux-btrace@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <kent.overstreet@gmail.com>,
        <yuchao0@huawei.com>, <jaegeuk@kernel.org>,
        <damien.lemoal@wdc.com>, <konrad.wilk@oracle.com>,
        <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH V4 9/9] xen/blkback: use helper in vbd_sz()
Message-ID: <20190715103640.i6gwasdjdkltm47n@MacBook-Air-de-Roger.local>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
 <20190708184711.2984-10-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708184711.2984-10-chaitanya.kulkarni@wdc.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 08, 2019 at 11:47:11AM -0700, Chaitanya Kulkarni wrote:
> This patch updates the vbd_sz() macro with newly introduced helper
> function to read the nr_sects from block device's hd_parts with the
> help of part_nr_sects_read().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
