Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170503125602.26956-1-gerald.schaefer@de.ibm.com>
References: <20170503125602.26956-1-gerald.schaefer@de.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 3 May 2017 11:44:16 -0700
Message-ID: <CAPcyv4hFcTLtTnMYXHnnijX0o8TG=r+cDXH4TBEuXJT+j8ebiw@mail.gmail.com>
Subject: Re: [PATCH] brd: fix uninitialized use of brd->dax_dev
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, May 3, 2017 at 5:56 AM, Gerald Schaefer
<gerald.schaefer@de.ibm.com> wrote:
> commit 1647b9b9 "brd: add dax_operations support" introduced the allocation
> and freeing of a dax_device, but the allocated dax_device is not stored
> into the brd_device, so brd_del_one() will eventually operate on an
> uninitialized brd->dax_dev.
>
> Fix this by storing the allocated dax_device to brd->dax_dev.
>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Thanks Gerald, I added this to the dax_device conversion for 4.12.
