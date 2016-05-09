Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46063 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbcEIH4B (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 9 May 2016 03:56:01 -0400
Date: Mon, 9 May 2016 09:55:57 +0200
From: Johannes Thumshirn <jthmshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] libnvdimm: cleanup nvdimm_namespace_common_probe(),
 kill 'host'
Message-ID: <20160509075557.GC4677@c203.arch.suse.de>
References: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146274691573.10891.13888079498835955317.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <146274691573.10891.13888079498835955317.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, May 08, 2016 at 03:35:15PM -0700, Dan Williams wrote:
> The 'host' variable can be killed as it is always the same as the passed
> in device.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
