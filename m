Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A195218A3
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867458; cv=none; b=TRykoyotY/9mDk4xHQ0iMijiNYyG+qtt2WqfvTKIJ2n4sh+aUiLL9I4wYsqXm7nzel+Qwp2Ofasb0XkLmHvF5t+DwUkXL6m4AfMhuqNW2J1ed7dIa0E/YV5I2c10r0dj6kpWET26Pr8Te2aIbDmdRANRdFbLb5/h40YAI+2SafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867458; c=relaxed/simple;
	bh=v/g5V0DvX7DbXaWcxFQ+1tPtcUqZhm9i5DBwg6+5XvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1oHffcUlf1VJDqXhCcucVGwDzSCUYTt6jkSTMBzARbvRD4ObNi13d/MPDuvU6LKoHGxcK/wSZ4shH+j2rE/EPapbgCsxAXDYrCr/ng1MOoVxaKamjCyKYnM9+en4UJQIWGS5plMs3FsH969isJhD7fooy0whvdefYnzExMCCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AiP95NAI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AiP95NAI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso19991085e9.2
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790867454; x=1791472254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEqFwwmiLgxzbUfdtxr/SjfsZs2IKekOzMd4LW1gk/0=;
        b=AiP95NAIGlVILCdx2fiDa96u9dnETu0eV6g2YlJVBoBtvumBMglaWOXWFSV84t6/kz
         BqOsphx4VuiYuLRPu99byiKeo8RE2xooIDYIHfbh86TZkkv/5UeVSnstEr8348Rz46hZ
         fve2SenUs/pMePKaFO4+N1wd1ixb8hEaZN5poOv/ul25F2BJ8HpDB1gllxiD829mumCo
         KwMqRHG1dPu5KZz2QJQ8Nw84T5h2jVBTdjFjfgHVSIpynmep6z56Mo6OL//CvuK2cJIR
         lzjG/fg06VwwJIAAujnM6PMf0N+p3DPRGdZnLrjVb5AzeoHbOF6WDB6PB/4aecr4uK+l
         Ck5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867454; x=1791472254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEqFwwmiLgxzbUfdtxr/SjfsZs2IKekOzMd4LW1gk/0=;
        b=eXzxPj562z/Ld9nfuhlM+l326QbcZmXYn4tOluuZ0jbl11Be4hDKXRx5/9jPdMUhLF
         7tEIfzgOci2vrJQc3fMp8dTPTW0d87IvIgyUG6U952Gyl7Vw3ucYRKP56lbVARPj5/tm
         tFGWFBFrWM/KItoT826ER4URuREFO98QUeNTg4w7wvl8KQqJtk863IyBL2L8x/VG0mXS
         qhxCO/0OYGSlw7voHET+VKU9zuu/BdMX970VuVCv02a0l3uXuBzTqDMTcPq97/uGBb0S
         XPhaAa3sR+tfrlWGbSJCsBjtx2mPNQLrtrpsYF8YLTyZXbRlwCHEUj6j8yGOa54EP2aL
         AaJw==
X-Forwarded-Encrypted: i=1; AKwUvByfw90S7LLZonRHOujDDhNAIc/qC208taGQMYUEI2mfP0VwLsK4Kh6s7P5RP9pgdKMiBWl/zyHxrXuy3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lZuDYenKhXgDm3G/J/VjyJixlt1F0aKuSzdDUlu6omKXxTHtk4
	F9i8rbiPgCYfAKeLjI/4IrvFzmmvdYwxv145ODiVSUNI3GzoNSYW4//P/ENpUtDjDOI=
X-Gm-Gg: AYBFou3aFJHRxUidc9ii5YXYfi74w84CdCgRt12p2e/oS3KYKV4o3tJCf1qjm4kq06D
	ps+4W+RdcwR9lEAmyZqdL+700bqL6OUWuctOIATjAHdiQwdVSdd4WUBgLTYP+txLgJBKc2ihhBZ
	XnAVvhn+wrhOv8jXrdvNrurh86TLBKMFDcdCehOSJiOohtHLcUK/Pib0dwlZ99oLK57GaqcTzJc
	xC3neeMx356YDwP3UGdgwh1iU1I3jolvs+AMF4iSc3Iuss4PlM2kKd5/XzLBEn0tnBnHNH/f4Rj
	RdhAeXKIr2qyRTxGB5OKmfCHbQs/OUOQLrfzt5Ifmkyj07fbZDlEME8lTqFkXK7i7kSljpvhBNv
	O1B2u5RTQ5Nuyx3tbuxLRclVhyxxfkUgNpFIl4TiDYxs/BgrfTWGzfGkRhksb9IfY/wreS42Kpk
	/t9uDPEKHGBt33AJa2ADH3RwXH3a7vzscz/4h0XDeoGsvO1fNHCG+JWc3NcFVx0FPXOsp6LgHGD
	pFl9d4/sCvoxdfDjvAG8IDCP037FzNTwSQ=
X-Received: by 2002:a05:600d:8499:20b0:4a0:1e68:d27d with SMTP id 5b1f17b1804b1-4a01e68d354mr47259215e9.9.1790867454233;
        Thu, 01 Oct 2026 08:10:54 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2fc98sm6247090f8f.35.2026.10.01.08.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 08:10:51 -0700 (PDT)
Message-ID: <ca910292-5d3d-47b5-ae40-7ca1688f3c06@suse.com>
Date: Thu, 1 Oct 2026 17:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Remove the error-injection.h include from
 linux/module.h
To: petr.pavlu@suse.com
Cc: Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, linux-api@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 5:04 PM, Petr Pavlu wrote:
> linux/module.h appears in roughly 15k #include directives across the
> kernel. This makes it a "hot" header, so it should avoid pulling in
> unnecessary definitions.
> 
> The header currently includes linux/error-injection.h to obtain the
> definition of `struct error_injection_entry`. However, this is unnecessary
> because the type is only referenced in the file as a pointer, for which an
> incomplete type is sufficient.
> 
> Add explicit includes of linux/error-injection.h to files that use the
> ALLOW_ERROR_INJECTION() macro and currently rely on it being provided
> indirectly via linux/module.h. Then remove the linux/error-injection.h
> include from linux/module.h.
> 
> The first five patches can go through their respective trees if preferred.
> The final patch depends on the preceding cleanups.

I've queued the series on modules-next for 7.4-rc1.

-- 
Thanks,
Petr
