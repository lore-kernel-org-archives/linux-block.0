Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 06/12] block: add helpers for setting/checking write hint validity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
	<1497544930-19174-7-git-send-email-axboe@kernel.dk>
Date: Fri, 16 Jun 2017 12:47:42 -0400
In-Reply-To: <1497544930-19174-7-git-send-email-axboe@kernel.dk> (Jens Axboe's
	message of "Thu, 15 Jun 2017 10:42:04 -0600")
Message-ID: <yq1a857q3pt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> +static const unsigned int rwf_write_to_opf_flag[] = {
> +	0, REQ_WRITE_SHORT, REQ_WRITE_MEDIUM, REQ_WRITE_LONG, REQ_WRITE_EXTREME
> +};

Minor nit: When I see WRITE_SHORT I instinctively think data corruption.

Can we make these REQ_LIFETIME_SHORT or something instead? It loses the
WRITE moniker which I'm not so keen on. But I'm not sure how we'd define
read lifetime...

-- 
Martin K. Petersen	Oracle Linux Engineering
