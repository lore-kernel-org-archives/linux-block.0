Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7215 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750994AbcFJDf6 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 23:35:58 -0400
Subject: Re: [PATCH] block: bio: kill BIO_MAX_SIZE
To: Ming Lei <ming.lei@canonical.com>, <linux-kernel@vger.kernel.org>
References: <1465529234-31195-1-git-send-email-ming.lei@canonical.com>
CC: <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Mike Christie" <mchristi@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Keith Busch <keith.busch@intel.com>,
	Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <575A3573.7010401@fb.com>
Date: Thu, 9 Jun 2016 21:35:15 -0600
MIME-Version: 1.0
In-Reply-To: <1465529234-31195-1-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/09/2016 09:27 PM, Ming Lei wrote:
> No one need this macro now, so remove it. Basically
> only how many bvecs in one bio matters instead
> of how many bytes in this bio.
>
> The motivation is for supporting multipage bvecs, in
> which we only know what the max count of bvecs is supported
> in the bio.

Applied, thanks.

-- 
Jens Axboe

