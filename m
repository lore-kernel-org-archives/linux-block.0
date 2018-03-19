Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 21:01:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/11] block: sed-opal: get metadata about opal-sed
	tables
Message-ID: <20180319200120.GJ3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <623d80cb07538e630a12a1c925e9c87b8e14dd6b.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <623d80cb07538e630a12a1c925e9c87b8e14dd6b.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:52PM +0100, Jonas Rabenstein wrote:
> Every opal-sed table is described in the OPAL_TABLE_TABLE. Provide a
> function to get desired metadata information out of that table.

Your new function doesn't seem to be used at all.
