Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbcFIWpf (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 18:45:35 -0400
Subject: Re: [PATCH 2/2] block: add a separate operation type for secure erase
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com
References: <1465480836-32093-1-git-send-email-hch@lst.de>
 <1465480836-32093-3-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Mike Christie <mchristi@redhat.com>
Message-ID: <5759F18C.9060200@redhat.com>
Date: Thu, 9 Jun 2016 17:45:32 -0500
MIME-Version: 1.0
In-Reply-To: <1465480836-32093-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/09/2016 09:00 AM, Christoph Hellwig wrote:
> Instead of overloading the discard support with the REQ_SECURE flag.
> Use the opportunity to rename the queue flag as well, and remove the
> dead checks for this flag in the RAID 1 and RAID 10 drivers that don't
> claim support for secure erase.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Nice.

Reviewed-by: Mike Christie <mchristi@redhat.com>
