Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669738E5EF
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079909; cv=none; b=F04Es4kJ4NmZpJETNhlYl7TuRpZBS0pbKegcFRkLddl8Dp+3FugK7nnHBcADveU64Xj5zt5tobngwMT/aXnIsyp3ibHcws72otgWuP2D5uC8gZeC1W+oTX+6uGr+PSHUHuwluBiwTb287Vfp+2z6mGNvnOT6uLEuo87hXy9ph7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079909; c=relaxed/simple;
	bh=MpdpneTahvV7dd4HcsSGeHrxkz25aKOWFS75pW4RUUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS5ootY4sOLeZWS8UGd0gOMJxhNWhP4SxY0CcQQ0jQpmkVAfJs9pZD8spzX3y0E0rgWbP2Sk/xArZ3ddx+vNwQW1JC9eIKHZtHeRtbMyLt8CzQHS5CF849wVVMrusks1VMF+IbN4s1jmsaBQ2rqEJW/z/5Rat4V3OOOd6RFuMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hy+l7Nvs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hy+l7Nvs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so22502545e9.3
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790079906; x=1790684706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0UH5f4Xwx0eHqEEdAgzMEXfye5CzpFBUkt22qJELao=;
        b=Hy+l7Nvsvo9rIAYpCVWkHs6HGyNyhzOkkQRTy8gSbTEX43W5TBKiKl5Rsq2vL2q4Xa
         tlvCGB3P9/nWTtSS/kfXZsJKmf7DztSyf70rq//z8fnUlWcRY1uUzXYXGROk2IBY33zU
         8oStgmYcQRd6FTmTHt0Y9+SFUZQE1bdXpWy60pf4ldc7VG5wD09wh3X4ErndVWPRQmu7
         J5L0WU+fzwMisPGY/tKfKj7COQr8KU/ym+Ca8T/cKcA8o9dJwP2HVy7rvjeaHsiU8GY7
         vu07oL5xw2yQnNhCyOKJ2ueOAIlDJul1MXNCGAw2fxzkASqhOTkv+y6V25FqfD5TgxDP
         NxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079906; x=1790684706;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0UH5f4Xwx0eHqEEdAgzMEXfye5CzpFBUkt22qJELao=;
        b=eCjEbgvSENfXIa3euxsRBDE2YPa9PNklmqqCkQebjtAcosNEuxfxAeN39EtwY8/FK/
         VggRUbZdKyGP25rdlLb5jesj1JweVNzGgLV0CfeFwL57PXjJaaFk/ZqJ33+nkUykT2uA
         2Ni8ZqvIXNSLjVHL9wXWdUjZJT+LLbWpT+gU9FGb23hR3h2AA7UXEfsth4TGT+aAVSed
         yC/8T84qZd6gqSmU80cDD9mrXpGfRFNB4WCoNvxX36BF5oUsbpAwYIhBo0EPFeFzHDVB
         d/bs0YNIlafQyodmKUUATTzojd0RpTaMGeFXWHebhXU64MRYbwQW0mFwErsGdrNDaZB6
         D+uw==
X-Forwarded-Encrypted: i=1; AKwUvBycf4Yy8XgW6TRpumzTODwsruz7JiB6i0KbrbECSFrETFDsIX4LaQPIquVN5tpo9gJhrUte/rAg1iF50Q==@vger.kernel.org
X-Gm-Message-State: AFuF++loo5dOCik1hgswYTukGT4mjC5dHRjVo7JuA0u5BeqS7ksWxZ8a
	ewfCuu/yhfzdjODBJayScCmk4hvTKdyJ+cA2HLAEB7y0CrqZCBhvfemXNXpCI+fqKiI=
X-Gm-Gg: AYBFou02AYdNocsfdWs6Lzdog838mgrvtg8bXmglc8vLZjf4IQj6dfiwQILbqZnkJ4f
	MLpGRMKO9iPNnONUwIaEWK5ZGpdyoUc3IovQW5Oipp0oh5mHxemxitMuji3SsyqAoT6N/DQi5WF
	gjGw/0GiaMcZEn4NXmrIqPVN6GzwjhcLSukpjzZRb/aYkfRIjhl2F+O1uHqD8HCJurmVGi16WTy
	7cX/NLqtAei9Vl/n4mOGjL5518CUa2YuQ2dG6ZL7WIY4tXaaRRMZ+9aa2XEnikIxB+NydsTnSx4
	cpecdgtccBRs+4ZEEQR9uy1B60W5XWzImfHOe5GF8Ls//bitAm2qCxLGF10E3H4HVdP4rXDvPQl
	lwuMxPUQL+8CtOQMrlZ5AlcemotOWfK4AHHUAzvM/QcNbZjm9YsAuj2cHf6oSNL2TuFIzpQrwae
	z2TYwpPTDKCFb4fsuq3T52+/TPu5WbkQRcD0ysRJt5j8LB05f4UVUtDmPrcnOcpIGXlq5D4xvvN
	kKRoOojepJMWPfPtc/fCgr7l7696EahygSj0NKeAzXkJ0AhlBLkD8P12lzenJXUNe0KPpQSn3E+
	fiJDL4wzwPktw2rKSgO4m+Cfv+1QsFvJW/UiJaKB
X-Received: by 2002:a05:600c:1f95:b0:49e:7862:c09e with SMTP id 5b1f17b1804b1-49fc57238b8mr181860835e9.14.1790079905892;
        Tue, 22 Sep 2026 05:25:05 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad40b4dsm48644925e9.10.2026.09.22.05.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 05:25:05 -0700 (PDT)
Message-ID: <d7bdb421-4c65-4133-95fa-ecf3ea2b7374@suse.com>
Date: Tue, 22 Sep 2026 14:25:04 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Remove the error-injection.h include from
 linux/module.h
To: Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
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

Thanks for the Reviewed-by and Acked-by tags so far. They cover the
majority of the changes, so I plan to pick up this series on
modules-next at the end of the week. Acked-by tags from the relevant
maintainers on the remaining patches are still appreciated.

-- 
Thanks,
Petr
