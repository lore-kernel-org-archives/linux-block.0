Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E2C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29DD20663
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="icICU74h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfLLLqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:46:24 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:14089 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLLLqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 06:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576151183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/nxsGOBE3z4PzlqxdwsQCYIwr15kAEC2A0iA/M8NzNg=;
  b=icICU74h003kifl2jdm+et2D3XyEB/t2n2OKVEVCcGgCUxRwFHU86tlM
   9mxtm+IS4VBf5YSMZJIclIXAHzRqIYiFedlueLeW8PJ14Q2KPQsIQCoHP
   9mywOaI9VdnrkeTDm37NYK21wx309rz+F2MNRjKyad6fdUKuxmB7DvnV5
   k=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: XQ11SJm5VCacmy8DmwUR5YBttttsCxa7c+4A6W5FO1lnetauOgWcBAilaBYOG9mjh8og6E3E7k
 d80WC/dPXXp7i7xvlxin2xOzS6ZEj9NH9TmKSZdDqAt2bj54bVwMAiEI7tdLcAiE+j9CfaYKWO
 pZkPtYjN+yWKdCifxyVjGfk4fvf4j2dhKFNM7remQHt4HVxXGwqwGzumCPmBnssCTJRCv7h45i
 VcJsqxjiLT/VcVDb0Qz6li+5fFT09GmlRKpT2gAbnYu1RJRQs5xKEpSw/h+OfZSNXQu3rpsF0m
 g0g=
X-SBRS: 2.7
X-MesageID: 9932140
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,305,1571716800"; 
   d="scan'208";a="9932140"
Date:   Thu, 12 Dec 2019 12:46:16 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: Re: [PATCH v3 4/4] xen-blkback: support dynamic unbind/bind
Message-ID: <20191212114616.GC11756@Air-de-Roger>
References: <20191211152956.5168-1-pdurrant@amazon.com>
 <20191211152956.5168-5-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211152956.5168-5-pdurrant@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 03:29:56PM +0000, Paul Durrant wrote:
> By simply re-attaching to shared rings during connect_ring() rather than
> assuming they are freshly allocated (i.e assuming the counters are zero)
> it is possible for vbd instances to be unbound and re-bound from and to
> (respectively) a running guest.
> 
> This has been tested by running:
> 
> while true;
>   do fio --name=randwrite --ioengine=libaio --iodepth=16 \
>   --rw=randwrite --bs=4k --direct=1 --size=1G --verify=crc32;
>   done
> 
> in a PV guest whilst running:
> 
> while true;
>   do echo vbd-$DOMID-$VBD >unbind;
>   echo unbound;
>   sleep 5;
>   echo vbd-$DOMID-$VBD >bind;
>   echo bound;
>   sleep 3;
>   done
> 
> in dom0 from /sys/bus/xen-backend/drivers/vbd to continuously unbind and
> re-bind its system disk image.
> 
> This is a highly useful feature for a backend module as it allows it to be
> unloaded and re-loaded (i.e. updated) without requiring domUs to be halted.
> This was also tested by running:
> 
> while true;
>   do echo vbd-$DOMID-$VBD >unbind;
>   echo unbound;
>   sleep 5;
>   rmmod xen-blkback;
>   echo unloaded;
>   sleep 1;
>   modprobe xen-blkback;
>   echo bound;
>   cd $(pwd);
>   sleep 3;
>   done
> 
> in dom0 whilst running the same loop as above in the (single) PV guest.
> 
> Some (less stressful) testing has also been done using a Windows HVM guest
> with the latest 9.0 PV drivers installed.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks!

Juergen: I guess you will also pick this series and merge it from the
Xen tree instead of the block one?

Roger.
