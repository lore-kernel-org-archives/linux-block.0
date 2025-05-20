Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DF264A97;
	Tue, 20 May 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741317; cv=none; b=kYa16XSo5O7LKj3WyBmP3iHJ1OaBdV9mMXHgNcvP95d0MLJJ4MG++LVahh0qjSpfSJxa52wVPEuic8S0XvUJnjunjA1c19lfNbZim4PqJIfDGhVPEKzTBcDcxXlq+LgAlYeHzFbUmPRvhl1RxqzIoX0XSfA0f7gJA+qrYcaGKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741317; c=relaxed/simple;
	bh=Ol9uSUbn2ZXUEH7qPHx1R0OZwskdpIKlJmZWMIzJyx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0De42pD7Bk3YwV8d+qxTi5hmXbfCferNarFTsmfsBoTxxSz5RGEs1Jbt64d2eg/f2349uQIy0wj0h9fJeb4yine38qKjnnHrq6FcMZyxTFPGcKwMqiSAWxuv79SqWKsPWgeCz7Ob9FgKdfYGAzsIOT/jntQPfdC6x8A5jm+u6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xlMulO2A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xlMulO2A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gmbzrUDxNH6PC6UchGiFgjmo8NW7xqmXvSTFLPxF/Cw=; b=xlMulO2AMDAuGzlA+wUXGreICR
	OMnwUw/rpLkCYmXF8UB3nAQsv+nXbwFlNYhir8BYinsR5VIrecbip+b6b9MzTTfiLZ0dq0adVezJt
	3ulsNAFAGUt89V9tzMopwhCSkRgKmep6kC+y2F7znyRrdaVgGc0g9u0FcK51L0uMz3ixWLy7O7Bdx
	HNcONENmdg933DhQOIn7cnniPIwICXO70r5w02C6liIFPzkYg9tRBR5YMbLWZBDXtaFJsPsbPbTYp
	vagARtVbh7jByNCTNUfHIIXbQVZnFNkj4F8k38Qyl/TQEiU8em5h8TPEJL4jVd4wsFPWAcGb3M/+7
	2Lxncu5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHLM0-0000000CghJ-0yKU;
	Tue, 20 May 2025 11:41:52 +0000
Date: Tue, 20 May 2025 04:41:52 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Christian Hesse <mail@eworm.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"christian@heusel.eu" <christian@heusel.eu>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com" <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?= =?utf-8?B?5aSNOg==?=
 [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <aCxqgDkHPHxrOFJH@infradead.org>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCwlRMEuvvP31UGG@infradead.org>
 <BL1PR11MB5979CBE5243379E686674B1C869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCxnTIwiVhBK-XIt@infradead.org>
 <BL1PR11MB5979E4700AE4B7B6A09681B8869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5979E4700AE4B7B6A09681B8869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 20, 2025 at 11:39:48AM +0000, Xu, Lizhi wrote:
> No, isofs does not support read_iter.

isofs does use generic_file_read_iter as read_iter method through
generic_ro_fops.  Why do you keep insisting on a wrong answer instead
of simply checking what read* method is used by isofs?

