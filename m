Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/6] block: make part_in_flight() take an array of two
 ints
Date: Fri, 4 Aug 2017 19:38:22 +0000
Message-ID: <1501875501.2757.25.camel@wdc.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
	 <1501859062-11120-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-4-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
> Instead of returning the count that matches the partition, pass
> in an array of two ints. Index 0 will be filled with the inflight
> count for the partition in question, and index 1 will filled
> with the root infligh count, if the partition passed in is not the
> root.

Hello Jens,

It looks like a letter 't' is missing from the patch description ("infligh"=
)?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
