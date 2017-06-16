Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 06/12] block: add helpers for setting/checking write hint
 validity
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, hch@infradead.org
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
 <1497544930-19174-7-git-send-email-axboe@kernel.dk>
 <yq1a857q3pt.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <916fd420-f6e0-bfac-daf2-535f2bca45ff@kernel.dk>
Date: Fri, 16 Jun 2017 10:53:48 -0600
MIME-Version: 1.0
In-Reply-To: <yq1a857q3pt.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:47 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> +static const unsigned int rwf_write_to_opf_flag[] = {
>> +	0, REQ_WRITE_SHORT, REQ_WRITE_MEDIUM, REQ_WRITE_LONG, REQ_WRITE_EXTREME
>> +};
> 
> Minor nit: When I see WRITE_SHORT I instinctively think data corruption.
> 
> Can we make these REQ_LIFETIME_SHORT or something instead? It loses the
> WRITE moniker which I'm not so keen on. But I'm not sure how we'd define
> read lifetime...

I did have that same feeling when writing it... The good news is that v6
will just use the WRITE_HINT_* types everywhere, so this one is already
gone.

-- 
Jens Axboe
