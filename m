Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:58:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 04/11] block: sed-opal: unify error handling of
	responses
Message-ID: <20180319195801.GF3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <4a20f9848927d0f654491136e4821f2adab131cc.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4a20f9848927d0f654491136e4821f2adab131cc.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:46PM +0100, Jonas Rabenstein wrote:
> Also response_get_token had already been in place, its functionality had
> been duplicated within response_get_{u64,bytestring} with the same error
> handling. Unify the handling by reusing response_get_token within the
> other functions.

Should probably be one patch for each of the two separate changes.

Except for that this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
