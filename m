Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1on0066.outbound.protection.outlook.com ([157.56.110.66]:53088
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752051AbcF1HXV (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 03:23:21 -0400
Subject: Re: [PATCH v5 3/5] um: track 'parent' device in a local variable
To: Dan Williams <dan.j.williams@intel.com>, <axboe@fb.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146705580842.39775.16180359577535598750.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>,
	"Jeff Dike" <jdike@addtoit.com>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>, <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <5965be1f-6b0b-d6f7-f6b0-d73b9be87267@sandisk.com>
Date: Tue, 28 Jun 2016 09:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <146705580842.39775.16180359577535598750.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/27/2016 09:30 PM, Dan Williams wrote:
> In preparation for the removal of 'driverfs_dev' from 'struct gendisk'
> use a local variable to track the parented vs un-parented case in
> ubd_disk_register().

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
