Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-12-git-send-email-axboe@kernel.dk>
 <F554C3E7-F38E-4F9F-80BA-B82353FFA8C8@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <07f799fb-0d0d-492f-d05e-b51af5e954d7@kernel.dk>
Date: Tue, 13 Jun 2017 15:18:16 -0600
MIME-Version: 1.0
In-Reply-To: <F554C3E7-F38E-4F9F-80BA-B82353FFA8C8@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 03:12 PM, Andreas Dilger wrote:
>> +static int nvme_streams_params(struct nvme_ns *ns)
>> +{
>> +	struct nvme_ctrl *ctrl = ns->ctrl;
>> +	struct streams_directive_params s;
>> +	struct nvme_command c;
>> +	int ret;
>> +
>> +	memset(&c, 0, sizeof(c));
>> +	memset(&s, 0, sizeof(s));
> 
> Minor nit in a few places in this code - is it more efficient to initialize
> these structs at declaration time instead of calling memset(), like:
> 
> 	struct streams_directive_params s = {};
> 	struct nvme_command c = {};
> 
> or alternately initializing them fully at declaration time to avoid zeroing
> fields that are immediately being set:
> 
> 	struct nvme_command c =
> 	{
> 		.directive.opcode = nvme_admin_directive_recv;
> 		.directive.nsid = cpu_to_le32(ns->ns_id);
> 		.directive.numd = sizeof(s);
> 		.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
> 		.directive.dtype = NVME_DIR_STREAMS;
> 	};

I'm just following the style of the driver for that part.
 
-- 
Jens Axboe
