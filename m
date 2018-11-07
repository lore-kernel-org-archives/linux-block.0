Return-Path: <keith.busch@intel.com>
Date: Wed, 7 Nov 2018 08:44:12 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
Message-ID: <20181107154412.GB11941@localhost.localdomain>
References: <20181107143745.11845-1-keith.busch@intel.com>
 <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain>
 <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 07, 2018 at 11:44:59PM +0800, Ming Lei wrote:
> blk_update_request() may tell us how much progress made, :-)

Except when it doesn't, which is 100% of the time for many block
drivers, including nvme.
