Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C44A3F2;
	Fri,  7 Aug 2026 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085856; cv=none; b=SAmrnCnXCMZhhOn9SmXsbOYqMNzy4RHRlOesc5RnbrxLPXjHQynvcWg5i0uvjyS4oXmc72MKQOIM5idocbStP3nFPr7z2+k79EeBxH0MBt8qpk0wTSxY4YNllqzXrsoZexZ75wTBmp5uPM33gmDw/UZ76rOMkwfvqcRepUkEAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085856; c=relaxed/simple;
	bh=dc6jcfvy7vglyuHlPrwaKsCY9clZBY3rTocwJo/NisY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcJZmbTvs6VRISZLDmHt9sBcUGepB2fiXlSrSVCqbVjoZzmmZOn0oct4OevnsBLkW9e6w005W8OsBeBU0+vNWzikLXxTRtXlX5Kwlh/EDj/XDiVP/ieaP0taHXZBCe1cAyAKqMm+OPALmD9+jAJKkp0YbT9Zni+6GmtJq48g5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f2e8474922d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6e5058bf-50fe-412c-b516-5a6d946d3ff8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:85864ecb076565b23df8d881dfd2a629,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f2e8474922d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 721897004; Fri, 07 Aug 2026 14:57:25 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: mst@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v2 1/2] virtio-pci: add error_detected for PCI AER recovery
Date: Fri, 7 Aug 2026 14:15:00 +0800
Message-ID: <reply-v3-mst-1-2.20260807.141500.liuxixin@kylinos.cn>
In-Reply-To: <20260802165915-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn> <e2dda946e70e.v2.1785468000.git.liuxixin@kylinos.cn> <20260802165915-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi Michael,

Thanks for the review.  I will post a v3 with the following.

On Sun, Aug 02, 2026 at 05:10:21PM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 31, 2026 at 11:17:00AM +0800, Xixin Liu wrote:
> > virtio-pci only registered reset_prepare/reset_done.  The PCI error
> > recovery core treats devices without error_detected as NO_AER_DRIVER and
> > does not deliver pci_channel_io_perm_failure to the driver after a failed
> > recovery.
>
> Maybe it should?

Agreed that the current PCI core behaviour is awkward for drivers that
only wire reset_prepare/reset_done.

Without .error_detected the recovery core votes NO_AER_DRIVER on the
first broadcast, and report_perm_failure_detected skips the driver
callback whenever overall status is not RECOVERED.  That skip covers
NO_AER_DRIVER even when subordinate reset succeeded.  uevent DISCONNECT
is still emitted.

Changing the core would be a PCI-wide policy change.  This series
registers .error_detected and joins the existing ERS contract the same
way other ERS-aware drivers do.  Happy to follow up on the PCI side if
that is preferred.

> > +	 * permanent failure break virtqueues (follow-up may call driver
> > +	 * .shutdown for block teardown).
>
> block specifically? this is common code.

Right, that wording was wrong for virtio-pci.  On perm_failure the
common path only calls virtio_break_device() and returns DISCONNECT.
Same for every virtio device.

> > +		return PCI_ERS_RESULT_NEED_RESET;
>
> so I guess pci will do slot reset? but what will call driver reset
> later? confused.

NEED_RESET asks for a PCI bus or slot reset.  On AER that is
aer_root_reset() then pci_bus_error_reset().  That path does not call
.reset_prepare or .reset_done; those hooks still serve FLR.  Driver
restore after a successful reset is .slot_reset.  v3 adds that hook and
it restores config then calls virtio_device_reset_done().  Quiesce stays
in error_detected on frozen via virtio_device_reset_prepare().  If the
PCI reset fails, .slot_reset is skipped and perm_failure only breaks
the device.

> > +	default:
> > +		break;
> > +	}
> > +	return PCI_ERS_RESULT_NEED_RESET;
>
> here, too, and we didn't virtio_device_reset_prepare either.

Right.  pci_channel_state_t today is only normal, frozen, and
perm_failure.  In v3 frozen and default share one path: quiesce via
virtio_device_reset_prepare(), then NEED_RESET.

Thanks,
Xixin

