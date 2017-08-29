Return-Path: <axboe@kernel.dk>
Date: Tue, 29 Aug 2017 08:31:31 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
Message-ID: <20170829143130.GA4857@kernel.dk>
References: <20170813170219.GG18698@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170813170219.GG18698@decadent.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Aug 13 2017, Ben Hutchings wrote:
> The block core requests modules with the "-iosched" name suffix, but
> bfq no longer has that suffix.  Add an alias.

I'd apply these two, but both patches are mangled when saved. It's
turning == into =3D and so forth.

Care to check your settings and resend?

-- 
Jens Axboe
