Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952193;
	b=xP/ei3wNdcxXXrHM8BapVtz3qjI/QwKngmlW5swEhq0RAnFrca0gDPT8j6OL3fitlGbm
	 xIJg8/+vI1Ogel2zk5YpUKTedLDcExZPFTSZlyyPFNJckoXqxiKr3HL3UaJuy7MPpb+Sk
	 /jgHbgfyHRvVVubtntZKhYM0BHoZ6km+QwajJmPMj4fG/XwO9kC2MegyzsOnLlPOT4SXO
	 KIBnjwjJiF7HMEoNZxgx6C7L5sI2oQW5MjFGbieoQC3INkrbMkS4u6JkxgkJl5HLqrBXo
	 4aK3lkc0yeLxazVWwaSgisEK3hGNnLgNvz0TfcGdt5cg92on1OxY7wHK/i1zlpJ43Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952193;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=S736nhFGPimfLh9pCUbirAbS2rs839sN1ph5aYvq+dc=;
	b=TRLvIo295YcaewhneCK33dm86gWjqGgzx5rKLUDV8cJ8oIqnA8ttKmvdvUMBuiSfJVaD
	 svZWgwMvVGrchEco+IjmZ/Ij+oIiHi6kdAg1Ko7HLa+OXQLTnLfuRZsSsmvBelrdiuUBS
	 Q6zGyT8Bao6USG6rXIoI0KEkk0PFE4WrDAAgmSUx5vMdT3ctoto/yMj9TuxwovlrrWYv5
	 gZgt51kX2raiDnQ03bsNUWyrp8XKoPrkNma2ON9NEJnJA3OYZNDzCghDMp4XlODo/kuFj
	 t1bnGbUBaDunRmwSHUnUpu2Ttty5c6hrmeGMC+5lPV1EBaWRcwhTnsBDIhsnZsw6adQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5E606A326;
	Fri,  6 Nov 2026 08:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09FC868BEB; Fri,  6 Nov 2026 09:03:00 +0100 (CET)
Date: Fri, 6 Nov 2026 09:03:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Haris Iqbal <haris.iqbal@linux.dev>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v3 for-next 1/3] block: Reject unknown status tags in error
 injection rules
Message-ID: <20261106080300.GA3696@lst.de>
References: <20260928221634.43239-1-haris.iqbal@linux.dev> <20260928221634.43239-2-haris.iqbal@linux.dev> <20261005084917.GA9160@lst.de> <20261020223402.GA1582237-mkhalfella@purestorage.com> <58a98f7d-b2c5-47b5-a372-0ab5afa6a8ed@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a98f7d-b2c5-47b5-a372-0ab5afa6a8ed@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 05, 2026 at 09:00:27PM +0100, Haris Iqbal wrote:
>> Doing it this way will result in use-after-free. "tag" has already been
>> freed above.
>>
>> Maybe change tag_to_blk_status() to return an int (0 on success and
>> -EINVAL on failure) and use its return value without mapping it?
>
> I am not sure I get your suggestion completely. Even if we change the 
> return type of tag_to_blk_status(), we would have to free the "tag" before 
> returning.

Let's just ignore my suggestion as it obviously does not work.

