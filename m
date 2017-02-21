Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41101 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751864AbdBUVT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 16:19:26 -0500
Subject: Re: [PATCH] scsi_transport_sas: fix BSG ioctl memory corruption
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <e33a218846e718a310fd8bd92acbafd0b6252aca.1487700062.git.osandov@fb.com>
CC: Christoph Hellwig <hch@lst.de>, <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c100b2a7-4359-b91a-5174-091920cd6fc6@fb.com>
Date: Tue, 21 Feb 2017 14:19:15 -0700
MIME-Version: 1.0
In-Reply-To: <e33a218846e718a310fd8bd92acbafd0b6252aca.1487700062.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2017 11:03 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The end_device and sas_host devices support BSG ioctls, but the
> request_queue allocated for them isn't set up to allocate the struct
> scsi_request payload. This leads to memory corruption in the call to
> scsi_req_init() in bsg_map_hdr(), since it will memset past the end of
> the allocated request. Fix it by setting ->cmd_size on the allocated
> request_queue.

Good catch, thanks Omar. Applied.

-- 
Jens Axboe
