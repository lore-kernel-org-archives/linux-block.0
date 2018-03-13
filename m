Return-Path: <scott.bauer@intel.com>
Date: Tue, 13 Mar 2018 09:53:38 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] block: sed-opal: support write to shadow mbr
Message-ID: <20180313155337.uz6uxdpeonbjwa2l@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 13, 2018 at 02:08:53PM +0100, Jonas Rabenstein wrote:
> Hi,
> this patchset adds support to write data into the shadow mbr of sed-opal
> enabled devices. They apply cleanly on today next-tree (next-20180313)
> and requires the u64 short atom length fix from [0] as that is still
> missing in that tree. As I only can test on my only sed-opal enabled
> Samsung 850 Evo on amd64, tests on other hardware would be appreciated.

Generally the series looks fine, there are a few nits I've sent out.
I will test and get back to you in the next day or two. With any further
comments.
