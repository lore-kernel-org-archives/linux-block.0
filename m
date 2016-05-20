Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48164 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbcETHat (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 20 May 2016 03:30:49 -0400
Date: Fri, 20 May 2016 09:30:46 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v3 5/5] libnvdimm: release ida resources
Message-ID: <20160520073046.GB4413@c203.arch.suse.de>
References: <146360496572.37439.6497663679891935585.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146360499323.37439.11321597319333400688.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <146360499323.37439.11321597319333400688.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 18, 2016 at 01:56:33PM -0700, Dan Williams wrote:
> ida instances allocate some internal memory for ->free_bitmap in
> addition to the base 'struct ida'.  Use ida_destroy() to release that
> memory at module_exit().
> 
> Reported-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
