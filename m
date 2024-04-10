Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967E1836CC
	for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783408; cv=none; b=Brz69UB0DmeDjfoI3vXFlYefeGj0sjLk2QWz3NbMBTUyPx/47o+yRBxiwqnmFtnLxNRXB/wdMC2pQ5KNQ/+wfu1k0JPU0a0eunOYfCECChDdvHtgpfNOlgxi7i4fqf6utdM1UjwIGBoqJ8ZnOwqJuK7t4PGrFvhRIDR7amcd+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783408; c=relaxed/simple;
	bh=bFyrIcuDs7nmErevy2zekDsqStQqLe+bXtd72c5CLDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBZoCHx9MaPuVa16jXYOc3d09oZdmL6ks0vUAYlD+UOZIoekWmA41CAUqT5Nrc8sbPb3SKaK+rjexS/Y0INJz4vKLXz9ooJBA+vMyV6K68wMb4qu22D686LXRy/DOPqRMx2T2NixI7kyrrQiIy0Mhtm3Rvk3YK39KSLMJs5GHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNqDt/ie; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNqDt/ie"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso6012124b3a.2
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783406; x=1713388206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv/V2BDcZ6BXQvfxxNM1w/X7hHGQqyp9bJFqKpeVUk0=;
        b=WNqDt/ieiDDCpUgP6O6kSxj5PVgwLbF1THE0dpO5cAhGSYnAcLyFM2h2ZYM73cjp0m
         sW3KlsnS0pwbtBZhVVv73zk25Y0cma1sfOSxSDXZjW8xp6gh7uWH5Rxow3wQRZ9dbNJB
         Fy8vnzyzSN7dwz3UMG4hcZ58Xd3P38YsKWKC1A7f18tnPQWS2WZqmzT56wN06oAvqma9
         cTzcZwExSvVWPPlfX3xOIffdLSDk2ARnk0fJh0vpd2W5nfwp+JZ1QQXiNvKmqMyBS/+P
         GiYzSObqpgC9DuLrrjKCk99Ryh62B9+9aXtkm9cFQHqIAt3AlvBVzT4S12QiE4IRp5aA
         SFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783406; x=1713388206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv/V2BDcZ6BXQvfxxNM1w/X7hHGQqyp9bJFqKpeVUk0=;
        b=VTXbzJa/LGE3ZWnjLysVg7Ne9OPE0uSJFk0ZqiUlHm2wDVtJMHAJDVZwg+FWHQdisk
         LXRJ/76XTXUqrjzZaFMhR4rescobwKjc9wQi7xd1dFcEUTR5cOnsoplttf06IDmZiQDH
         hojef8wXV367MKxWH/vSCNRrvaNr532/0sz0t6SDY7+7PKkxkyjvuEyywInG+uMqMUc8
         wSJiC6HgodpWZgiK1E7tCob8bcX39bqyk03DnlCMWGlgelN6gju2D3uJYL15HoOp/DEI
         M9214yZz9rI3OMNQpZ9YQcjukXPYQTDMGJFuRKLNuyWxDcB+lA5vwkorhC1PrINGNp5n
         Knqg==
X-Forwarded-Encrypted: i=1; AJvYcCUH3LYV8re7jZwnnKfDVszfjICgoKgCWjt4TTmJtAKVU9vCzMNrw94pBf9ollxPHAT1yBD9K/vgpor3yowOvuwsFk5es/ScF+19h8A=
X-Gm-Message-State: AOJu0Yz28kKy/fVMER2O8/SlE+L0tgJzQ/+NgpZoVHZXTqrzAmc1qXC8
	QbldrCSJyLIckzv0nTeJNEEPchCHut5paQDkWdBCu6HYuq8tH/vp7xznH4xeww==
X-Google-Smtp-Source: AGHT+IFcUUpsX3kBlOD2hO0EgX46DmOztzcA2srIGWOFuvp0m6/PaSUmCl09aWhXL/OfU4fhOLSkSg==
X-Received: by 2002:a05:6a00:3d42:b0:6ed:21bc:ed8c with SMTP id lp2-20020a056a003d4200b006ed21bced8cmr4678360pfb.18.1712783405518;
        Wed, 10 Apr 2024 14:10:05 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id w22-20020a634756000000b005dc4da2121fsm10368167pgk.6.2024.04.10.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:10:04 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:10:01 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] [v2] acpi: disable -Wstringop-truncation
Message-ID: <b5ijucc7vbamdivt5o36zqleunihy6j62u3ecg6p4jgqmajao6@xatdncyyp6jv>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-3-arnd@kernel.org>

Hi,

On Tue, Apr 09, 2024 at 04:00:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc -Wstringop-truncation warns about copying a string that results in a
> missing nul termination:
> 
> drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
>    60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
>    61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The code works as intended, and the warning could be addressed by using
> a memcpy(), but turning the warning off for this file works equally well
> and may be easir to merge.

Dang, I would've really liked to see these strncpy()'s dealt with [1]!

The warning is there because that specific usage of strncpy is plain
wrong. strncpy() is a string api and this usage looks like it has
arguments and results not resembling C-strings.

Not sure if turning off correct warnings is the right call.

Link: https://github.com/KSPP/linux/issues/90 [1]

> 
> Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
> Link: https://lore.kernel.org/lkml/CAJZ5v0hoUfv54KW7y4223Mn9E7D4xvR7whRFNLTBqCZMUxT50Q@mail.gmail.com/#t
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/acpica/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index 30f3fc13c29d..8d18af396de9 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -5,6 +5,7 @@
>  
>  ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
>  ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
> +CFLAGS_tbfind.o 		+= $(call cc-disable-warning, stringop-truncation)
>  
>  # use acpi.o to put all files here into acpi.o modparam namespace
>  obj-y	+= acpi.o
> -- 
> 2.39.2
> 

Thanks
Justin
