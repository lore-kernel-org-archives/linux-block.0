Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28813C3DD;
	Sat, 31 Aug 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725135190; cv=none; b=d4NAIwasSmzYxTsxZTo0DHPzMVp7dgYEanHQxe152+EDnRatHPkQRh7KePjndWgHTYClrxp3Ay1F0h4C70dc4QHcdxvcqSAOwSJktgHq7aMfZ6BbfwvZFSs3hsFmabKsgXaIx7jbfvYlhV8pSYEJ2eauI74Qf2TIDLYSz9LeeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725135190; c=relaxed/simple;
	bh=ZzTQzTuq8t5oY/rTJE7YtJirp5vrKWoK5bZkGOJtbKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj5KGF3NzMCP7G44DbUI245OSVdGHb+KuKt4JLAzDqBsx7ZEg4O0C+RIcGWRPq1i8zsntYOyK9v5oeLpMK6snWtV/EDZOdLNvq66UTBiXXRIyxPxxaT+NZByT0XkcYIZL0mwIWKhLXqAtnMYo80X8tG/o34YzbORwxlKN28k9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1vsmI6M; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1vsmI6M"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso2706919a12.3;
        Sat, 31 Aug 2024 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725135187; x=1725739987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfRWgLMsxUKb/pckPYUNERRt+VQJsqVrOKkUakzcqGY=;
        b=F1vsmI6MH0DMMvQlaIeii/sW+b5dKZ7z3kIRho3rdzyWqulNWpY3FjHbvrTwBfcJi4
         cgE/x+VnvS757Vlh8pAi/o9yUsFB77HpXFK9z03weyQ1ZSC4aIVzxQbykW96IslG4R8v
         ziXFfLdT41oMcI5ASY0IP72ZxbshA0VvePghVwwSSe4CcXYDepEl2c7Nr+6pNvKJXBJA
         L5yv4CXHVao/zdL5lh/Gh+i/wQNLMgAIBcPOoe2Cy32dIYSNqXPqS4E8liR2BUMXHF4k
         QgUeXl75iUHUSo7jQaOYAb9SKRGrlnx5+ja+4z4Q8/8gXEQ/T/Mjml7Jjz9V4ridcFII
         zvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725135187; x=1725739987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfRWgLMsxUKb/pckPYUNERRt+VQJsqVrOKkUakzcqGY=;
        b=ZreQzBFTdujU8SM3ppjdooyqIa96CHLLUrmvi9Fa2g2iq/qAt+jwXxkQO2DUPq+Ezp
         LsXDOAPVPBFyyzP0/fQ5JGMTuHgtVO0icj+VLUrj1aw+Iu353JJ+S8DTYxRnecT3H7GH
         JiWKW+UDA6fYbUjFDWojV4f0eL5Fg3ORsn++blOy3Bhgu3KwFTC5R4oL936XDptycneE
         LA1PJnRge8eyeVosLVArne8A4XaemOjLjsJPmxlZh/hvaeI3NuvEUj3quflqkn9ddPQr
         F91Vw3/EsKaibM1hT+5ymn50dN4lTsGpblC6O8YxFWd1+1YFAte4WvVgN1RTmo8dSoL5
         yR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZL6alN4yHTBJGbnCMBPc96npBlBm2UzXGcsJ+Ej2neSMQEeASSdsAn0kWsk1TD9OHCguTtS/L3gQaWQ==@vger.kernel.org, AJvYcCWwsvA3hEw/N/pY3fwJSQXA0XECK3a1tRYrysVM1lUjlAuuXdQVp6k1giM5qjUyj0g5b53kXQj/JHAbahQpZFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUmI7D2fXK58r85oiMkfIcYYeL+2uG+p4WdHP9rbgxr5inNM1
	EI8XqWH0w/Cw8qtViN+i3md5PhPhzd6q1cC+91nfvLYheF70Wus=
X-Google-Smtp-Source: AGHT+IGkh/mTBG7QZZu8N3Ot5v37GQWaoKdT3YZOoEWvlj4cT6tEM6fXro/64w81RYPgAd/LzKnSng==
X-Received: by 2002:a05:6402:13d2:b0:5be:dc90:d13f with SMTP id 4fb4d7f45d1cf-5c242350d99mr2146647a12.5.1725135186676;
        Sat, 31 Aug 2024 13:13:06 -0700 (PDT)
Received: from p183 ([46.53.252.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce784csm3284359a12.91.2024.08.31.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 13:13:06 -0700 (PDT)
Date: Sat, 31 Aug 2024 23:13:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] block, rust: simplify validate_block_size() function
Message-ID: <6ca8edb0-10f9-4967-b0d6-3510836fdbcf@p183>
References: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
 <CANiq72=pX32F4pDq85H=9pB=hmUcH59Xp7JoNGpKJ+XxkzovcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=pX32F4pDq85H=9pB=hmUcH59Xp7JoNGpKJ+XxkzovcQ@mail.gmail.com>

On Sat, Aug 31, 2024 at 09:02:15PM +0200, Miguel Ojeda wrote:
> On Sat, Aug 31, 2024 at 8:52 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Also delete few comments of "increment i by 1" variety.
> 
> They are not comments, those lines are part of the documentation.

Why do they duplicate the code 1:1?

Ignore the patch BTW, it was mangled by opening gmail Drafts :-(
