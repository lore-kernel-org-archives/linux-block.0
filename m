Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA213472771
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117696; cv=none; b=bu+WYuXctX1jbHXKhcUpZKq51xzztW0612BWGOaDPoERJ9Ow60t63lkdaO+9LgD9kO8DKqrcTRyrPZHsi18AB2+pNIvoynkUDi4mQBNkEFHxKpmF2ahjt+fDclohimbdYbNvwvfPeBf+rXLObHZMthxSqYRCxpAmme62LOfJbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117696; c=relaxed/simple;
	bh=aotFxEOLnNauY7xtHBzjVCJbiyl1TL0OjtQ0+qlXpWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQeEhUNVTQdcwiepfl9uDrF0jhv8v29gQFNwhth5z+LtnNGdN2bftxVajz7JI+dIhFJqBE7R0OgKyqrT0OozP4TLwi/nz5xKCU25M8vwSQKQ8uvojlJ8SrybHloQo6xGhAStyghzwszAjcgKMkm1OguXu5O7y6GQhOYCZ9q24BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5KNOtth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5KNOtth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC1B1F00A3A;
	Fri,  7 Aug 2026 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117694;
	bh=AaQwxE4B0+9LW3NYyaHCwEX2rgcqJTuS0/coE2np1sY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a5KNOtthj6BQRaOjpewAAizQIlt8HePBpSL026IYONvaHmXUB4KBHSHxkOL8fRR5S
	 1RoEYrFCqBEb1nwnxV8p3hfay5h4z26yQRGUqomq4ZCQdqtOx5mhUQuWJxdZrBEe5i
	 JbiZSOPvWhsIKZ4hYWPK673oORBSk67JFLZbgKkebeoekLtXJcOTtw23oOsZ8pGNM2
	 Wlv7R5RgmA8N7XEA029HpKN+b5jTSQrWp/8gxITtECvw/DqndOjdZndb8OFqswgo5w
	 AJo4xgvZ7MEoK+qLjOJvqF74CxbBdZNK0PrLU2XdhsyL+TLEj+UcCFDK16q7EUOMwA
	 wiYUERkS5Bmog==
Message-ID: <9ffd0912-8373-4d6e-9eaa-7fff63160b45@kernel.org>
Date: Fri, 7 Aug 2026 08:48:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] block: always treat offline and read-only zones
 as dead
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-10-dlemoal@kernel.org>
 <d6b95a4a-6cbc-46ac-8e7e-12ef8588447c@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <d6b95a4a-6cbc-46ac-8e7e-12ef8588447c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/07 3:46, Hannes Reinecke wrote:
> On 8/6/26 6:04 PM, Damien Le Moal wrote:
>> Since any write BIO targeting an offline or a read-only zone will fail,
>> there is no point in keeping zone write plugs for these zones.
>> So for any offline or read-only zone, the zone write plug should always
>> be treated as dead.
>>
>> Do this by modifying disk_check_zone_wplug_dead() to always mark read-only
>> and offline zones as dead to force a removal of the zone write plug from
>> the disk hash table on BIO submission. blk_zone_wplug_prepare_bio() is
>> also modified to have the same checks to immediately fail a write BIO
>> targeting a read-only or offline zone. With these two changes, any newly
>> issued or unplugged write BIO targeting a read-only or offline zone is
>> immediately failed.
>>
>> Finally, disk_zone_wplug_sync_state() is modified to add a call to
>> disk_mark_zone_wplug_dead() for the zone write plug of any read-only or
>> offline zone found during zone revalidation or a report zones.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   block/blk-zoned.c | 113 +++++++++++++++++++++++++---------------------
>>   1 file changed, 61 insertions(+), 52 deletions(-)
>>
> Makes one feeling sorry for filesystems having to deal with this ..

Yeah. If you depop a head under a mounted FS, the FS will not be happy :)

For file systems that can support it (e.g. XFS with metadata & log on a
different device), the plan is to execute depop going through the file system,
so that the FS can synchronize itself with zones going offline so that it does
not uselessly trip on IO errors and also can notify the user of affected files.


-- 
Damien Le Moal
Western Digital Research
