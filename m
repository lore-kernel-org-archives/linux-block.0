Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AE401A3B;
	Mon,  3 Aug 2026 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756726; cv=none; b=LfIkF6FC/W8yzWkjeEtjAKA3Jwg8qw3xbHh9ch75eIoAs/gI09oy+HwQ23nNJIpKbea5dF4ENmOuKX6E/qpKdQow+H/Wi+KvIpf6cNCdnGRvwv1UTFsxhITdS2ls2wOGMwwPKbwGO1pch/FZPD7mTGSmgVMICeBb5l9mNy+ctFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756726; c=relaxed/simple;
	bh=mOWQhO4OjqdA0XYsYKEqTFTMtPYCWTPuc+2xUlyYDPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEed0WwkO9OIkQVuNu3qJVeWxnbj8MMAZUYDK8jRZasfdrzH/Anz5OhF/BMUFjnlZ6ceAD3CcsKRj/G2SM1XK5ZyQx9yQZLIHLumqDI+vJ8N8TCGqwlZpqJDglcEse95BOSSYt88r7qwsmz1S7ZI+sj52ANZlzku26TWyzT+xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2wLwibS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2wLwibS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9C81F000E9;
	Mon,  3 Aug 2026 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785756724;
	bh=o955f/Mp8Xf8DxW6cblGlCcuM8HUOvHpBbcQTzfYj3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z2wLwibS6MpywdlShz9B0lv815pCtxJ5SV9kE645kN5XqKHnhvUwUyWMIUCzPFQBf
	 N3k0PF+PN3aS/LI81PzvBCnpSXmnkjSk9NASdQJ9BLFGU3zPm85/BKVhns29Fb35iz
	 fwhK62julFcVo3t+MfUYMlPA7X0BeXQDMSDGwo7L+CmYCtxRJRW7If03bIa3UpDF9Y
	 Lh0rxBgXSmU/5tdJGX5auEU+y40Ks8buaF3BuJTiywIXEYW4D350Z6WH9qBlm1myFj
	 Vz1jFKcJ88Txi4mFYKarkm5eXBDDPyDU2BKGDf75ZxalMNmyUXAqwD2+o0k4t0IBa/
	 JbxoBbtHEw0tA==
Date: Mon, 3 Aug 2026 13:32:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ric Lewis <riclewis@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: APPLE SSD SM0256G: host bus errors above 1280 KiB writes since
 9b8b84879d4a
Message-ID: <anB8MRnp0BXwQmu2@ryzen>
References: <MN2PR20MB3055A220221B11302F331A9AA5C82@MN2PR20MB3055.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR20MB3055A220221B11302F331A9AA5C82@MN2PR20MB3055.namprd20.prod.outlook.com>

Hello Ric,

On Fri, Jul 31, 2026 at 09:10:53PM +0000, Ric Lewis wrote:
> ## Patch
> 
>     --- a/drivers/ata/libata-core.c
>     +++ b/drivers/ata/libata-core.c
>     @@ static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
>       { "INTEL SSDSC2KG480G8",      "XCV10120", 8191 },
>     + { "APPLE SSD SM0256G",        "BXW1SA0Q", 2560 },
>       { },
>      };
> 
>     @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>       { "DELLBOSS VD",  "MV.R00-0", ATA_QUIRK_MAX_SEC },
> 
>     + /*
>     +  * Apple/Samsung S4LN058A01[SSUBX] AHCI SSD reports host bus errors on
>     +  * writes larger than 1280 KiB since commit 9b8b84879d4a.
>     +  */
>     + { "APPLE SSD SM0256G",  "BXW1SA0Q", ATA_QUIRK_MAX_SEC },
> 
>     Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
>     Cc: stable@vger.kernel.org

Patch looks good to, could you please send it as a formal patch?

https://docs.kernel.org/process/submitting-patches.html


Kind regards,
Niklas
