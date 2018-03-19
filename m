Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:53:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/11] block: sed-opal support write to shadow mbr
Message-ID: <20180319195335.GB3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:42PM +0100, Jonas Rabenstein wrote:
> Hi,
> I was advised to resend the patchset as a v2 where all the patches are
> in a flat hierarchy. So here is a complete set which hopefully pleases
> all requirements.
> As the previous fixes have by now all landed into linux-next, no
> additional patches are required for testing.

Btw, what userspace do you use for this?  The only one I know so far
is Scotts sed-opal-temp, which really should grow a more permanent
name / location.
