Return-Path: <axboe@kernel.dk>
Date: Thu, 4 May 2017 07:53:46 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 1/2] lightnvm: create cmd before allocating request
Message-ID: <20170504135345.GA9292@kernel.dk>
References: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 03 2017, Javier Gonz�lez wrote:
> Create nvme command before allocating a request using
> nvme_alloc_request, which uses the command direction. Up until now, the
> command has been zeroized, so all commands have been allocated as a
> read operation.

Applied 1-2. Javier, please use a cover letter when sending more than 1
patch at the time, makes it easier to reply to the series as a whole.

-- 
Jens Axboe
