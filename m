Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D770161310;
	Tue,  6 Aug 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930564; cv=none; b=WUjsCg+NfRerPOkij3TbfMQ0ARjwN4pxUgmUcdNcSI1uph1JTKROx8Yr8rUk7dFlIoJC6y02gjMKj/+2rfiGM+T+z7tstA72x1YiRkvdlPNgrcHMgggAz1rrBnphT8/X4z+T3MlUhyqGkQH5jRU5nTt/kseNMMcNNpVCIxqJqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930564; c=relaxed/simple;
	bh=9s0qX9EcCdK9Cz1xzXalamrvaY9+4khYtkIME4JNusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYAck2gS7x1LQurI1iaHF2ePm/I1+8vK4hwk29vw3x8s5ufIFHGUxSixqVEK+BbKCtqe50+ADI1GnlHPdSs2cA18pWfsTqORzzv4VMGMtKgn3vBAq8aVmnDrUwhpZtkKl7s4DQnMTJMFMlcoX4qCUjWrNlGjnLc2QScQVidltDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=uter.be; dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b=gdqWBr2O; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uter.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b="gdqWBr2O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
	s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3G8kWmCY8+8ycTTQtwqTo5kt3QPEPxhAtSHYBuxzt1E=; b=gdqWBr2OGUd+hdjhz2vxPeQx2g
	tYa1cZgdCCmtGvBVJKiqukSWovODXy9AF73NwJ8Qf/AtniKznQVGWkmU9jMDTVhzvayS875AjGTaX
	7TO4T/IjNtQpk62abcOGI5Sx5HaQYoxJbxTOqz6DdOD3GJ7NxXLTAW0e//OUc8C9ctLhOgqA/1wPC
	jM2HvgAqVfS0/4J9CwQLVMZmh2UpNSd5rZpv0TMDr1j2RUi/xrw0ylbEDIITVYoOE9RBiZ8IMtTAS
	DkVU2LJuOcvUksG2bPXPc1xCtdHEQOHJbrpsmKIraWzT3Eu69PCw17ZFY8paloR5DuQybcWY1LfDD
	tuR/PPBA==;
Received: from [102.39.154.62] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <w@uter.be>)
	id 1sbEwP-00EW3a-1L;
	Tue, 06 Aug 2024 09:49:09 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <w@uter.be>)
	id 1sbEwH-000000002oc-0XVH;
	Tue, 06 Aug 2024 09:49:01 +0200
Date: Tue, 6 Aug 2024 09:49:01 +0200
From: Wouter Verhelst <w@uter.be>
To: Eric Blake <eblake@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nbd: implement the WRITE_ZEROES command
Message-ID: <ZrHVbQ5_lvCCegK_@pc220518.home.grep.be>
References: <20240803130432.5952-1-w@uter.be>
 <f2kaityrjmmstzvqq7xu755ikstida2hcnnng634oeo6fxjfbj@zrgbeik6fwz6>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2kaityrjmmstzvqq7xu755ikstida2hcnnng634oeo6fxjfbj@zrgbeik6fwz6>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none

On Mon, Aug 05, 2024 at 07:52:42AM -0500, Eric Blake wrote:
> On Sat, Aug 03, 2024 at 03:04:30PM GMT, Wouter Verhelst wrote:
> > The NBD protocol defines a message for zeroing out a region of an export
> > 
> > Add support to the kernel driver for that message.
> > 
> > Signed-off-by: Wouter Verhelst <w@uter.be>
> > ---
> >  drivers/block/nbd.c      | 8 ++++++++
> >  include/uapi/linux/nbd.h | 5 ++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 5b1811b1ba5f..215e7ea9a3c3 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -352,6 +352,8 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
> >  	}
> >  	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
> >  		lim.features |= BLK_FEAT_ROTATIONAL;
> > +	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
> > +		lim.max_write_zeroes_sectors = UINT_MAX;
> 
> Is that number accurate, when the kernel has not yet been taught to
> use 64-bit transactions and can therefore only request a 32-bit byte
> length on any one transaction?  Would a better limit be
> UINT_MAX/blksize?

Thanks, good catch.

I copied the logic from the handling of the TRIM command (i.e., the
discard logic), which has the same flawed UINT_MAX behavior. I will fix
this in v2 and add a fix for the discard code.

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.
