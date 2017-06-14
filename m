Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-12-git-send-email-axboe@kernel.dk>
 <20170614203221.GD7022@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <978509f0-90aa-fb11-1872-76cad1710059@kernel.dk>
Date: Wed, 14 Jun 2017 14:43:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170614203221.GD7022@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 02:32 PM, Christoph Hellwig wrote:
>> +static unsigned int nvme_get_write_stream(struct nvme_ns *ns,
>> +					  struct request *req)
>> +{
>> +	unsigned int streamid = 0;
>> +
>> +	if (req_op(req) != REQ_OP_WRITE || !blk_stream_valid(req->cmd_flags) ||
>> +	    !ns->nr_streams)
>> +		return 0;
> 
> Might make more sense to do this check in the caller?

OK, will fix up.

>> +	if (req->cmd_flags & REQ_WRITE_SHORT)
>> +		streamid = 1;
>> +	else if (req->cmd_flags & REQ_WRITE_MEDIUM)
>> +		streamid = 2;
>> +	else if (req->cmd_flags & REQ_WRITE_LONG)
>> +		streamid = 3;
>> +	else if (req->cmd_flags & REQ_WRITE_EXTREME)
>> +		streamid = 4;
>> +
>> +	if (streamid < BLK_MAX_STREAM)
> 
> Can happen per the index above.

True, that's a leftover from the previous version.

>> +		req->q->stream_writes[streamid] += blk_rq_bytes(req) >> 9;
>> +
>> +	return (streamid % (ns->nr_streams + 1));
> 
> Should we do smarted collapsing?  e.g. short + medium and long + extreme
> for two?  What for three?  Does one extra stream make sense in this
> scheme?

Collapsing is probably saner than round-robin. I'd tend to collapse on
the longer life time end of things, logically that would make the most
sense.

>> +	dev_info(ctrl->device, "streams: msl=%u, nssa=%u, nsso=%u, sws=%u "
>> +				"sgs=%u, nsa=%u, nso=%u\n", s.msl, s.nssa,
>> +				s.nsso, s.sws, s.sgs, s.nsa, s.nso);
> 
> Way to chatty.

Sure, that's mentioned in the changelog, that stuff will go.

>> +	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
>> +		dev_info(ctrl->dev, "supports directives\n");
> 
> Same.  Use nvme-cli for that sort of info.

Ditto

>>  	ctrl->npss = id->npss;
>>  	prev_apsta = ctrl->apsta;
>>  	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
>> @@ -2060,6 +2201,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>  		goto out_free_id;
>>  	}
>>  
>> +	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
>> +		nvme_config_streams(ns);
> 
> This sets aside four streams on any device that supports them, and
> will probably kill performance on them unless you have a workload
> that actually uses those streams.  I think they need to be allocated
> lazily.

That's a good point, I have been thinking about how best to handle this.
I don't want an API for this, but doing it lazy would be fine. When we
see a write with a life time attached, kick off background setup of
streams. Until that's done, don't use any streams. Once setup, we'll
mark it as we currently do now.

How's that?

-- 
Jens Axboe
