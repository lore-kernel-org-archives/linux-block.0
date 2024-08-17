Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D3256E
	for <linux-block@vger.kernel.org>; Sat, 17 Aug 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723857769; cv=none; b=E6D+WH7n/vdiBWbQlsvL6iaJjr36DJUrDzzsi/9oUYo6VXfpVcejiMIGN3WpEBDkufbdCKnq1kbxHP8aAwh0GvXnec8clXcpmKoH1dga0j9DhdzBqA/wTHIyNn8kZZkVJUPh3xrlU0wKm25oWMP5ibKifhWoUV0pBRf7f6/BTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723857769; c=relaxed/simple;
	bh=iO6/x5Zd81gY7PD6d+FRDpJTzZcgjiHJyOptjx4w6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqfxwXfRjVQ5m8813sVTbgY1ka9TGb9D313qfNzlN4Y+JjRBBCOEaPs+xdzUmTPY/t4ahfwLM4G9+SesrknSKBymE6sWq7Dvtpxe9qChLPQYybO6SaNIhtFfdB629OCBwbdyL+rdBpUx3kvPy6PCE0tUN3x3vbxRHAg77bHcAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l7GYdcFa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7GYdcFa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lMkG4PqoNawkDXMb2RAu7qjIisr1ejDLyYeo4v+s2Hg=; b=l7GYdcFaNyj+jHTSFPJ/euAniL
	HIB99hMQD4kDZhQLvjafcYnK7GLF5IEhnPj5TUy7RgSqprrXjY6VN0/s9H4skH8LMRUyA0+fcTr5v
	JwXInG6nLY33LS5bdMq/lez+P7fvdciZXya2pHIAk5OeAny4k2q2Va+KUvMdPzdlE1omAliHEcxqF
	bH4xsJEjIwnsTFg2WjK7RcSjMDhM9KZy8X4ZcrWhzy8WxFJ4fL+a68+5cn3id6NrRUiv51Q6aQ2wA
	VtwyGqpTXoiOt5ZhnO9m6vuyeLLJJ671exEFVXo16JFlovMy8cT2WruumZUaNg1AuLMVbg+RHQArL
	rJlL4EeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sf89Q-0000000ERYT-2bKb;
	Sat, 17 Aug 2024 01:22:40 +0000
Date: Fri, 16 Aug 2024 18:22:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, kernel@pankajraghav.com,
	axboe@kernel.dk, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 0/5] block: add larger order folio instead of pages
Message-ID: <Zr_7YERr75vHbknA@bombadil.infradead.org>
References: <CGME20240711051521epcas5p348f2cd84a1a80577754929143255352b@epcas5p3.samsung.com>
 <20240711050750.17792-1-kundan.kumar@samsung.com>
 <ZrVO45fvpn4uVmFH@bombadil.infradead.org>
 <20240812133843.GA24570@lst.de>
 <Zro5xJgcVlSaM4zP@bombadil.infradead.org>
 <20240816084541.t7bn7qlklhynsglq@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816084541.t7bn7qlklhynsglq@green245>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Aug 16, 2024 at 02:15:41PM +0530, Kundan Kumar wrote:
> On 12/08/24 09:35AM, Luis Chamberlain wrote:
> > On Mon, Aug 12, 2024 at 03:38:43PM +0200, Christoph Hellwig wrote:
> > > On Thu, Aug 08, 2024 at 04:04:03PM -0700, Luis Chamberlain wrote:
> > > > This is not just about mTHP uses though, this can also affect buffered IO and
> > > > direct IO patterns as well and this needs to be considered and tested as well.
> > > 
> > > Not sure what the above is supposed to mean.  Besides small tweaks
> > > to very low-level helpers the changes are entirely in the direct I/O
> > > path, and they optimize that path for folios larger than PAGE_SIZE.
> > 
> > Which was my expectation as well.
> > 
> > > > I've given this a spin on top of of the LBS patches [0] and used the LBS
> > > > patches as a baseline. The good news is I see a considerable amount of
> > > > larger IOs for buffered IO and direct IO, however for buffered IO there
> > > > is an increase on unalignenment to the target filesystem block size and
> > > > that can affect performance.
> > > 
> > > Compared to what?  There is nothing in the series here changing buffered
> > > I/O patterns.  What do you compare?  If this series changes buffered
> > > I/O patterns that is very well hidden and accidental, so we need to
> > > bisect which patch does it and figure out why, but it would surprise me
> > > a lot.
> > 
> > The comparison was the without the patches Vs with the patches on the
> > same fio run with buffered IO. I'll re-test more times and bisect.
> > 
> 
> Did tests with LBS + block folio patches and couldn't observe alignment
> issue. Also, the changes in this series are not executed when we issue
> buffered I/O.

I can't quite understand yet either why buffered IO is implicated yet
data does not lie. The good news is I re-tested twice and I get similar
results **however** what I failed to notice is that we also get a lot
more IOs and this ends up even helping in other ways.  So this is not
bad, in the end only good. It is hard to visualize this, but an image
says more than 1000 words so here you go:

https://lh3.googleusercontent.com/pw/AP1GczML6LevSkZ8yHTF9zu0xtXkzy332kd98XBp7biDrxyGWG2IXfgyKNpy6YItUYaWnVeLQSABGJgpiJOANppix7lIYb82_pjl_ZtCCjXenvkDgHGV3KlvXlayG4mAFR762jLugrI4osH0uoKRA1WGZk50xA=w1389-h690-s-no-gm

So the volume in the end is what counts too, so let's say we
use a tool like the collowing which takes the blkalgn json file as
input and outputs worst case workload WAF computation:

#!/usr/bin/python3
import json
import argparse
import math

def order_to_kb(order):
    return (2 ** order) / 1024

def calculate_waf(file_path, iu):
    with open(file_path, 'r') as file:
        data = json.load(file)

    block_size_orders = data["Block size"]
    algn_size_orders = data["Algn size"]

    # Calculate total host writes
    total_host_writes_kb = sum(order_to_kb(int(order)) * count for order, count in block_size_orders.items())

    # Calculate total internal writes based on the provided logic
    total_internal_writes_kb = 0
    for order, count in block_size_orders.items():
        size_kb = order_to_kb(int(order))
        if size_kb >= iu:
            total_internal_writes_kb += size_kb * count
        else:
            total_internal_writes_kb += math.ceil(size_kb / iu) * iu * count

    # Calculate WAF
    waf = total_internal_writes_kb / total_host_writes_kb

    return waf

def main():
    parser = argparse.ArgumentParser(description="Calculate the Worst-case Write Amplification Factor (WAF) from JSON data.")
    parser.add_argument('file', type=str, help='Path to the JSON file containing the IO data.')
    parser.add_argument('--iu', type=int, default=16, help='Indirection Unit (IU) size in KB (default: 16)')

    args = parser.parse_args()
    file_path = args.file
    iu = args.iu
    waf = calculate_waf(file_path, iu)
    print(f"Worst-case WAF: {waf:.10f}")

if __name__ == "__main__":
    main()

compute-waf.py lbs.json --iu 64 
Worst-case WAF: 1.0000116423
compute-waf.py lbs+block-folios.json --iu 64 
Worst-case WAF: 1.0000095356

On my second run I have:

cat 01-next-20240723-LBS.json
{
    "Block size": {
        "18": 6960,
        "14": 302,
        "16": 2339746,
        "13": 165,
        "12": 88,
        "19": 117886,
        "10": 49,
        "9": 33,
        "11": 31,
        "17": 42707,
        "15": 89393
    },
    "Algn size": {
        "16": 2351238,
        "19": 117886,
        "18": 3353,
        "17": 34823,
        "15": 13067,
        "12": 40060,
        "14": 13583,
        "13": 23351
    }
}

cat 02-next-20240723-LBS+block-folios.json
{
    "Block size": {
        "11": 38,
        "10": 49,
        "12": 88,
        "15": 91949,
        "18": 33858,
        "17": 104329,
        "19": 129301,
        "9": 34,
        "13": 199,
        "16": 4912264,
        "14": 344
    },
    "Algn size": {
        "16": 4954494,
        "14": 10166,
        "13": 20527,
        "17": 82125,
        "19": 129301,
        "15": 13111,
        "12": 48897,
        "18": 13820
    }
}

compute-waf.py 01-next-20240723-LBS.json --iu 64
Worst-case WAF: 1.0131538374
compute-waf.py 02-next-20240723-LBS+block-folios.json --iu 64
Worst-case WAF: 1.0073550532

Things are even better for Direct IO :) and so I encourage you to
test as this is all nice.

Tested-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
