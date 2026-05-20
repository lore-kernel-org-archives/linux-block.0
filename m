Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97843370D52
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272681; cv=none; b=nnQwYN59TuFt1l1gVNlGy+TmQuO8JkIicN3OESPZI9hq5xQGhdVD7wSCjeKUhQEkH1kC2lbB/cN7dfTtkWBWj9q3oFa0q8IVA+I00zyojt2fXf6FsTiO12KjAJag2nxCNbLTMqKEoO4bwiql9Im82wtt36ORGVqX/DlO7uI+UAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272681; c=relaxed/simple;
	bh=BfWjIDXNjnj2p+kQmVq/HJg3vVHyxJFcZIPYOpkfbuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJcldiCl6+y6bEW3MTJda8Qn0PThs7iUjsbqU73BIGGGmWcHzUBCYuG8T+FAHWlP3UxX084ZWIaB4H7kYhlaLw1E/7qrnxCJtgrF61RIt6CwuVslFL0aJNbNYVPXu8btu1TNvVnQ0nfSk0OfKM2r2tAnQfC8cpy+TeP+1e1OMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxVb/ong; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxVb/ong"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44a5174670eso2657688f8f.1
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779272662; x=1779877462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjyw2SPSbDAWDTOYsBSPfcvH3EJiKjWBtVx5pcWE1q0=;
        b=BxVb/ongSTgvzKmg0Zk0oC8DO9RkVg2UIgroK+7p2VJQl8qQVY8RVlOOgxtQcFzzw4
         onVZWRuYyebR/WM55MuAg//Xw3CgSV+rTfJha3qiegcNlyfv7Rr9ILXFR/GaCK3BvFxh
         O31bthKBSI5iUg/mhe7kC6cGQ1e3omcc1ZLBgLXek9vbyypb/TJMT3yMyvSNaijo+/Nd
         4O2LGgWpL8qODA0kQa89jteiA3lNnbKr4Mf3apIQ0yKAYgT/dFcz+UPwPlY1NCXHYv94
         kvLgaKrE/FA9Z1zGWz5+4VzvCTHDZOsgaFIpAmXytDc4Ys2pc2YnqEQjx7/wUkpp9tB5
         sfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779272662; x=1779877462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjyw2SPSbDAWDTOYsBSPfcvH3EJiKjWBtVx5pcWE1q0=;
        b=luVHVhQik36WXV4Q1V/6/o+/hjHSN9V/lTz5gT2OBHk2R789jOWdtpzzY0o/D1Lbgu
         iENXD1tiIZ7eS6G34y7FQ0MXIZiZm4K9TymMfqmIvgPbPG7o58NDjtHb1WATm4PcWOO8
         EBaUiIOCupVxc7FR2YOaVOW5HkkehB7Zd2tV/4OgJBzHAw/+7IG+fv2WDv+S3gAd0AEE
         OZ8m/EL24SsPghxqHSrAKQ4fEsarxd99TNElNfq1sJSxLDHABXF2D92tB7KJ2rv2y1oU
         kaMU7UU1Fe8ClMIEV5NUyD/WPpZPBeM6rA8wikQO0TxnhvzezXBA8jEEtQAuidUDkKUn
         5Hlw==
X-Gm-Message-State: AOJu0Yz/6WjWTbKNZTf0Zc9IR2m75jFA5NKJQckNLmJMctmI2w/jwnkE
	B5lCOa5XWpEUe8fRXKo+RzIl9jKgX+7MKolDbTxPh3kEipC1+SnGRVZM
X-Gm-Gg: Acq92OFetLqGlUgz4PPXMg4i8YRlRvirqkLvnYBRKEgx7hjaBnqn4FsEa7QTVPvAiDu
	+G1QjaMM6pZ6tXkiNtiOiXrkj/qQMEhwDYUnD4F2Rn/Z0TyFGhtFr/UgR7W6+st8jWITFe9zg9K
	Rnx4KJ1syaKeikFnl8XgpiVX+alDvIUKQiqg2ojLFg66yHZM9Ri7zSen7eQHc25OiYodV9UY9pe
	5nTDOweswQBHyGdu2e80DdOv2Nto3R6nVPoEnJ2wDxsVpnNfchHqegdoJxuoqyvvo16EHioxML9
	p9qP8VjubacPOppkI1A42BtJCliKarTY3jxDo/YCNbi5XHww6fzsqd2Nzzj+XwtoesTNsKkWZpI
	NbTlOVyw7odIBP9BpFGBm5BHKi2SeZ9hZPWlzkNy2p+DPt9xZl7TAwp/g6qvWp9Dm5kT8Dbh8F5
	Y1o0jF2eoTZiH8p4QChd5v0yg=
X-Received: by 2002:a5d:5f45:0:b0:44d:821:1a0b with SMTP id ffacd0b85a97d-45e5c5dd260mr38410505f8f.29.1779272662508;
        Wed, 20 May 2026 03:24:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm51188114f8f.3.2026.05.20.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:24:21 -0700 (PDT)
Date: Wed, 20 May 2026 13:24:18 +0300
From: Dan Carpenter <error27@gmail.com>
To: gjoyce@linux.vnet.ibm.com
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
	brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
	nayna@linux.ibm.com, akpm@linux-foundation.org,
	ndesaulniers@google.com, nathan@kernel.org, jarkko@kernel.org,
	okozina@redhat.com
Subject: Re: [PATCH v8 3/3] powerpc/pseries: PLPKS SED Opal keystore support
Message-ID: <ag2L0kO_zK5hzx-W@stanley.mountain>
References: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
 <20231004201957.1451669-4-gjoyce@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004201957.1451669-4-gjoyce@linux.vnet.ibm.com>

On Wed, Oct 04, 2023 at 03:19:57PM -0500, gjoyce@linux.vnet.ibm.com wrote:
> +int sed_read_key(char *keyname, char *key, u_int *keylen)
> +{
> +	struct plpks_var var;
> +	struct plpks_sed_object_data data;
> +	int ret;
> +	u_int len;
> +
> +	plpks_init_var(&var, keyname);
> +
> +	if (!plpks_sed_available)
> +		return -EOPNOTSUPP;
> +
> +	var.data = (u8 *)&data;
> +	var.datalen = sizeof(data);
> +
> +	ret = plpks_read_os_var(&var);
> +	if (ret != 0)
> +		return ret;
> +
> +	len = min_t(u16, be32_to_cpu(data.key_len), var.datalen);
                                                    ^^^^^^^^^^^
This isn't the correct limit.  This is the number of bytes that we
copied into data.  Probably it's sizeof(data) and, hopefully, it's
at least the offsetof(struct plpks_sed_object_data, key).

To me the temptation is the initialize data to zero and
s/var.datalen/sizeof(data.key)/.

> +	memcpy(key, data.key, len);
                    ^^^^^^^^

> +	key[len] = '\0';
> +	*keylen = len;
> +
> +	return 0;
> +}

regards,
dan carpenter
