Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 55/55] skd: Bump driver version
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Akhil Bhansali <Akhil.Bhansali@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
 <20170817201338.16537-56-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <73d0f010-99dc-8d6b-5acd-178306a6a6e2@kernel.dk>
Date: Thu, 17 Aug 2017 14:45:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170817201338.16537-56-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2017 02:13 PM, Bart Van Assche wrote:
> Bump the driver version. Remove the build ID because build IDs do
> not make sense for an upstream kernel driver. Keep the driver
> version in the module information but do not report it during every
> load, unload or probe.

Just kill the version completely.

-- 
Jens Axboe
