Return-Path: <linux-block-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:44723 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752109AbcF1IOP (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 04:14:15 -0400
Subject: Re: [PATCH v5 3/5] um: track 'parent' device in a local variable
To: Bart Van Assche <bart.vanassche@sandisk.com>,
	Dan Williams <dan.j.williams@intel.com>, axboe@fb.com
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146705580842.39775.16180359577535598750.stgit@dwillia2-desk3.amr.corp.intel.com>
 <5965be1f-6b0b-d6f7-f6b0-d73b9be87267@sandisk.com>
Cc: linux-nvdimm@lists.01.org, Jeff Dike <jdike@addtoit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de
From: Richard Weinberger <richard@nod.at>
Message-ID: <577231CF.6000301@nod.at>
Date: Tue, 28 Jun 2016 10:14:07 +0200
MIME-Version: 1.0
In-Reply-To: <5965be1f-6b0b-d6f7-f6b0-d73b9be87267@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Am 28.06.2016 um 09:23 schrieb Bart Van Assche:
> On 06/27/2016 09:30 PM, Dan Williams wrote:
>> In preparation for the removal of 'driverfs_dev' from 'struct gendisk'
>> use a local variable to track the parented vs un-parented case in
>> ubd_disk_register().
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
