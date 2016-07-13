Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52433 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751362AbcGMQVg (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 13 Jul 2016 12:21:36 -0400
Subject: Re: [PATCH] block: Fix front merge check
To: Damien Le Moal <damien.lemoal@hgst.com>,
	<linux-block@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>
References: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <57866A2B.5000403@fb.com>
Date: Wed, 13 Jul 2016 09:19:55 -0700
MIME-Version: 1.0
In-Reply-To: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/12/2016 10:23 PM, Damien Le Moal wrote:
> For a front merge, the maximum number of sectors of the
> request must be checked against the front merge BIO sector,
> not the current sector of the request.

Why does this matter? The merging should only happen before we start the 
request, hence rq pos and first bio should be one and the same.

-- 
Jens Axboe

