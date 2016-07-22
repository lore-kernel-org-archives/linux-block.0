Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:34105 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbcGVUf5 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 22 Jul 2016 16:35:57 -0400
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Damien Le Moal <damien.lemoal@hgst.com>
Subject: Re: [PATCH 1/6] blk-sysfs: Add 'chunk_sectors' to sysfs attributes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
	<1468934439-93579-2-git-send-email-hare@suse.de>
Date: Fri, 22 Jul 2016 16:35:45 -0400
In-Reply-To: <1468934439-93579-2-git-send-email-hare@suse.de> (Hannes
	Reinecke's message of "Tue, 19 Jul 2016 15:20:34 +0200")
Message-ID: <yq14m7hbece.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Hannes" == Hannes Reinecke <hare@suse.de> writes:

Hannes> The queue limits already have a 'chunk_sectors' setting, so we
Hannes> should be presenting it via sysfs.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
