Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B190BA
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 10:52:05 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE9FB227A8E; Tue,  5 Dec 2023 19:52:01 +0100 (CET)
Date: Tue, 5 Dec 2023 19:52:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: support adding less than len in
 bio_add_hw_page
Message-ID: <20231205185201.GA21354@lst.de>
References: <20231204173419.782378-1-hch@lst.de> <20231204173419.782378-3-hch@lst.de> <819e3e00-a658-424f-9e08-95a670dd301a@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <819e3e00-a658-424f-9e08-95a670dd301a@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 05, 2023 at 04:34:02PM +0000, Johannes Thumshirn wrote:
> On 04.12.23 18:35, Christoph Hellwig wrote:
> > [...] All the existing callers are fine with
> > this - not because they handle this return correctly, but because they
> > never pass more than a page in.
> 
> 
> Wouldn't it also be beneficial to do proper return checking in the 
> current callers on top of this series?

I did look into that - but given how they are structured it would
create an even bigger mess.  Except for the nvmet zns backend they
all either allocate the added page right next to them or take the
output from a pin_user_pages variant.
