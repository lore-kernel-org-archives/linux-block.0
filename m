Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50197 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcF1L64 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 07:58:56 -0400
Date: Tue, 28 Jun 2016 13:58:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: axboe@fb.com,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <keith.busch@intel.com>, linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>, hch@lst.de
Subject: Re: [PATCH v5 4/5] block: convert to device_add_disk()
Message-ID: <20160628115855.GC28578@lst.de>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com> <146705581355.39775.16995803612126463831.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <146705581355.39775.16995803612126463831.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
